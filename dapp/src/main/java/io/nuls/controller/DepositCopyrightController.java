package io.nuls.controller;

import io.nuls.Config;
import io.nuls.Constant;
import io.nuls.base.RPCUtil;
import io.nuls.base.basic.AddressTool;
import io.nuls.base.basic.TransactionFeeCalculator;
import io.nuls.base.data.CoinData;
import io.nuls.base.data.CoinFrom;
import io.nuls.base.data.CoinTo;
import io.nuls.base.data.Transaction;
import io.nuls.base.signture.P2PHKSignature;
import io.nuls.controller.core.BaseController;
import io.nuls.controller.core.Result;
import io.nuls.controller.vo.RegisteredEntityData;
import io.nuls.core.constant.CommonCodeConstanst;
import io.nuls.core.core.annotation.Autowired;
import io.nuls.core.core.annotation.Component;
import io.nuls.core.crypto.ECKey;
import io.nuls.core.crypto.HexUtil;
import io.nuls.core.exception.NulsException;
import io.nuls.core.exception.NulsRuntimeException;
import io.nuls.core.rpc.util.NulsDateUtils;
import io.nuls.rpc.AccountTools;
import io.nuls.rpc.LegderTools;
import io.nuls.rpc.TransactionTools;
import io.nuls.rpc.vo.Account;
import io.nuls.rpc.vo.AccountBalance;
import io.nuls.service.DepositCopyrightService;
import io.nuls.service.RegisteredEntityService;
import io.nuls.service.dto.CopyrightContent;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.io.IOException;
import java.math.BigInteger;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

/**
 * @Author: zhoulijun
 * @Time: 2019-06-11 21:03
 * @Description: 功能描述
 */
@Path("/")
@Component
public class DepositCopyrightController implements BaseController {

    @Autowired
    Config config;

    @Autowired
    AccountTools accountTools;

    @Autowired
    LegderTools legderTools;

    @Autowired
    TransactionTools transactionTools;

    @Autowired
    DepositCopyrightService copyrightService;

    @Autowired
    RegisteredEntityService registeredEntityService;
    /**
     * 生成一个邮件收件地址
     * 需要扣除1个NULS作为手续费
     *
     * @param req
     * @return
     */
    @Path("deposit")
    @Produces(MediaType.APPLICATION_JSON)
    @POST
    public Result<String> deposit(CopyrightContent req){
        return call(()->{
            Objects.requireNonNull(req.getAddress(), "sender address can't null");
            Objects.requireNonNull(req.getPassword(),"sender address password can't null");
            Objects.requireNonNull(req.getApplicantId(),"applicantId can't null");
            Objects.requireNonNull(req.getAuthorization(),"authorization can't null");

            //验证账户有效性
            accountTools.accountValid(
                    config.getChainId(),
                    req.getAddress(),
                    req.getPassword());

            //提交版本信息人必须为链上注册用户
            if (!registeredEntityService.hasUsername(req.getApplicantId())) {
                throw new NulsRuntimeException(CommonCodeConstanst.FAILED, "applicantId not found onchain:" + req.getApplicantId());
            }

            Account account = accountTools.getAccountByAddress(req.getAddress());
            Transaction tx = createDepositTrasaction(account, req);
            //签名别名交易
            signTransaction(tx, account, req.getPassword());
            if (!transactionTools.newTx(tx)) {
                throw new NulsRuntimeException(CommonCodeConstanst.FAILED);
            }
            return new Result<>(tx.getHash().toHex());
        });
    }

    /**
     * 组装交易
     * @param account
     * @param req
     * @return
     */
    private Transaction createDepositTrasaction(Account account,CopyrightContent req) throws IOException, NulsException {
        Optional<RegisteredEntityData> registeredEntityData = registeredEntityService.getRegisteredEntity(req.getApplicantId());
        if(registeredEntityData.isEmpty()){
            throw new NulsRuntimeException(CommonCodeConstanst.PARAMETER_ERROR,"can't found registered entity : " + req.getApplicantId() );
        }

        Transaction tx = new Transaction();
        tx.setType(Constant.TX_TYPE_ONCHAIN_DEPOSIT);
        tx.setTime(NulsDateUtils.getCurrentTimeSeconds());
        tx.setTxData(req.serialize());
        tx.setCoinData(buildCoinData(tx, AddressTool.getAddress(req.getAddress())));
        return tx;
    }

    private byte[] buildCoinData(Transaction tx, byte[] senderAddress) throws IOException, NulsException {
        AccountBalance accountBalance = legderTools.getBalanceAndNonce(config.getChainId(), AddressTool.getStringAddressByBytes(senderAddress), config.getChainId(), config.getAssetId());
        byte locked = 0;
        byte[] nonce = RPCUtil.decode(accountBalance.getNonce());
        CoinFrom coinFrom = new CoinFrom(senderAddress, config.getChainId(), config.getAssetId(), config.getStandardFee(), nonce, locked);
        CoinTo coinTo = new CoinTo(AddressTool.getAddress(Constant.BLACK_HOLE_ADDRESS), config.getChainId(), config.getAssetId(), config.getStandardFee());
        int txSize = tx.size() + coinFrom.size() + coinTo.size() + P2PHKSignature.SERIALIZE_LENGTH;
        //计算手续费
        BigInteger fee = TransactionFeeCalculator.getNormalTxFee(txSize);
        //总费用为
        BigInteger totalAmount = config.getStandardFee().add(fee);
        //验证发件人余额是否足够
        if(accountBalance.getAvailable().min(config.getStandardFee().add(tx.getFee())).equals(accountBalance.getAvailable())){
            throw new NulsRuntimeException(CommonCodeConstanst.FAILED, "insufficient fee");
        }
        coinFrom.setAmount(totalAmount);
        CoinData coinData = new CoinData();
        coinData.setFrom(List.of(coinFrom));
        coinData.setTo(List.of(coinTo));
        return coinData.serialize();
    }


    /**
     * 获取指定用户的注册实体
     *
     * @param hash
     * @return
     */
    @Path("getCopyright/{hash}")
    @Produces(MediaType.APPLICATION_JSON)
    @GET
    public Result<CopyrightContent> getRegisteredEntity(@PathParam("hash") String hash) {
        return call(()-> new Result(copyrightService.getCoyprightContent(hash)));
    }

}
