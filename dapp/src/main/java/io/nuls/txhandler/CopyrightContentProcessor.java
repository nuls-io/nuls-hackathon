package io.nuls.txhandler;

import io.nuls.Config;
import io.nuls.Constant;
import io.nuls.base.basic.AddressTool;
import io.nuls.base.basic.NulsByteBuffer;
import io.nuls.base.data.*;
import io.nuls.controller.vo.FileInfo;
import io.nuls.controller.vo.RightDescription;
import io.nuls.core.core.annotation.Autowired;
import io.nuls.core.core.annotation.Component;
import io.nuls.core.exception.NulsException;
import io.nuls.core.log.Log;
import io.nuls.rpc.LegderTools;
import io.nuls.rpc.vo.AccountBalance;
import io.nuls.service.DepositCopyrightService;
import io.nuls.service.RegisteredEntityService;
import io.nuls.service.dto.CopyrightContent;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * @Author: zhoulijun
 * @Time: 2019-06-11 20:39
 * @Description: 功能描述
 */
@Component
public class CopyrightContentProcessor implements TransactionProcessor {

    @Autowired
    RegisteredEntityService registeredEntityService;

    @Autowired
    DepositCopyrightService depositCopyrightService;

    @Autowired
    Config config;

    @Autowired
    LegderTools legderTools;

    @Override
    public int getType() {
        return Constant.TX_TYPE_ONCHAIN_DEPOSIT;
    }

    @Override
    public boolean validate(int chainId, Transaction tx, BlockHeader blockHeader) {
        Log.info("validate copyright tx");
        try {
            NulsHash nulsHash = NulsHash.calcHash(tx.serializeForHash());
            if (!nulsHash.equals(tx.getHash())) {
                return false;
            }

            CopyrightContent copyrightContent = new CopyrightContent();
            copyrightContent.setFileInfo(new FileInfo());
            copyrightContent.setRightDescription(new RightDescription());
            copyrightContent.parse(new NulsByteBuffer(tx.getTxData()));

            //验证是否为有效的注册实体
            if(!registeredEntityService.hasUsername(copyrightContent.getApplicantId())){
                return false;
            }
            //验证是否转入指定资产到手续费账户
            CoinData coinData = new CoinData();
            coinData.parse(new NulsByteBuffer(tx.getCoinData()));
            List<CoinFrom> from = coinData.getFrom();
            //支付账户只能有一个
            if(from.size() != 1) {
                return false;
            }
            CoinFrom cf = from.get(0);

            if(!Arrays.equals(cf.getAddress(),AddressTool.getAddress(copyrightContent.getAddress()))){
                return false;
            }
            List<CoinTo> to = coinData.getTo();
            //收款账户只能有一个
            if(to.size() != 1) {
                return false;
            }
            CoinTo ct = to.get(0);
            //验证收款地址是否是手续费地址
            if(!Arrays.equals(ct.getAddress(),AddressTool.getAddress(Constant.BLACK_HOLE_ADDRESS))){
                return false;
            }
            //验证支付的申请费用是否正确 出金 = 入金 + 手续费
            if(!((ct.getAmount().add(tx.getFee())).equals(cf.getAmount()) && ct.getAmount().equals(config.getStandardFee()))){
                return false;
            }

            //验证余额是否足够支付申请费用和交易手续费
            AccountBalance accountBalance = legderTools.getBalanceAndNonce(config.getChainId(), AddressTool.getStringAddressByBytes(cf.getAddress()), config.getChainId(), config.getAssetId());
            if(accountBalance.getAvailable().min(ct.getAmount().add(tx.getFee())).equals(accountBalance.getAvailable())){
                return false;
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (NulsException e) {
            e.printStackTrace();
        }
        return true;
    }

    @Override
    public boolean commit(int chainId, Transaction tx,BlockHeader blockHeader) {
        Log.info("commit deposit copyright");
        try {
            NulsHash nulsHash = NulsHash.calcHash(tx.serializeForHash());
            if (!nulsHash.equals(tx.getHash())) {
                return false;
            }
            CopyrightContent copyrightContent = getTxData(tx);
            depositCopyrightService.saveCopyright(tx.getHash().toHex(),copyrightContent);
        }catch (Throwable e){
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    public boolean rollback(int chainId, Transaction tx,BlockHeader blockHeader) {

        return false;
    }

    public CopyrightContent getTxData(Transaction tx) throws NulsException {
        CopyrightContent copyrightContent = new CopyrightContent();
        copyrightContent.setFileInfo(new FileInfo());
        copyrightContent.setRightDescription(new RightDescription());
        copyrightContent.parse(new NulsByteBuffer(tx.getTxData()));
        return copyrightContent;
    }
}
