package com.green.controller;

import com.green.controller.core.BaseController;
import com.green.controller.core.Result;
import com.green.pojo.MessageUser;
import com.green.rpc.AccountTools;
import com.green.rpc.LegderTools;
import com.green.rpc.TransactionTools;
import com.green.rpc.vo.Account;
import com.green.rpc.vo.AccountBalance;
import com.green.service.MessageService;
import com.green.utils.Config;
import com.green.utils.Constant;
import io.nuls.base.RPCUtil;
import io.nuls.base.basic.AddressTool;
import io.nuls.base.basic.TransactionFeeCalculator;
import io.nuls.base.data.*;
import io.nuls.base.signture.P2PHKSignature;
import io.nuls.core.constant.CommonCodeConstanst;
import io.nuls.core.crypto.HexUtil;
import io.nuls.core.exception.NulsException;
import io.nuls.core.exception.NulsRuntimeException;
import io.nuls.core.model.BigIntegerUtils;
import io.nuls.core.model.StringUtils;
import io.nuls.core.rpc.util.NulsDateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.math.BigInteger;
import java.util.Arrays;

@RestController
@CrossOrigin
@RequestMapping("/regist")
public class CreateCountController implements BaseController {


    @Autowired
    Config config;

    @Autowired
    AccountTools accountTools;

    @Autowired
    LegderTools legderTools;

    @Autowired
    TransactionTools transactionTools;

    @Autowired
    MessageService messageService;



    @RequestMapping(value="/user",method= RequestMethod.PUT)
    public Result<String> createMessageUser(@RequestBody MessageUser req)  {
        return call(() -> {
            Transaction tx = null;
            int chainId = config.getChainId();
            if (!AddressTool.validAddress(chainId, req.getAddress().toString())) {
                throw new NulsRuntimeException(CommonCodeConstanst.PARAMETER_ERROR);
            }
            if (!validUserName(req.getUserName())) {
                throw new NulsRuntimeException(CommonCodeConstanst.PARAMETER_ERROR);
            }
            //验证账户有效性
            accountTools.accountValid(config.getChainId(), req.getAddress().toString(), req.getPassword());
            Account account = accountTools.getAccountByAddress(req.getAddress().toString());
            if (messageService.hasAddressOrUsername(req.getAddress().toString(), req.getUserName())) {
                throw new NulsRuntimeException(CommonCodeConstanst.FAILED, "address  already set mail address : " + req.getUserName());
            }
            tx = createMessageUserTrasactionWithoutSign(account, req.getUserName());
//        //签名别名交易
            signTransaction(tx, account, req.getPassword());
            if (!transactionTools.newTx(tx)) {
                throw new NulsRuntimeException(CommonCodeConstanst.FAILED);
            }
            return new Result<>(tx.getHash().toHex());
        });
    }

    private Transaction createMessageUserTrasactionWithoutSign(Account account, String userName) throws NulsException, IOException {
        Transaction tx = null;
        tx = new Transaction();
        tx.setType(Constant.TX_TYPE_CREATE_USER_ADDRESS);
        tx.setTime(NulsDateUtils.getCurrentTimeSeconds());
        MessageUser ma = new MessageUser();
        ma.setAddress(AddressTool.getAddress(account.getAddress()));
        ma.setUserName(userName);
        ma.setPubKey(HexUtil.decode(account.getPubkeyHex()));
        tx.setTxData(ma.serialize());
        //设置别名烧毁账户所属本链的主资产
        int assetsId = config.getAssetId();
        //查询账本获取nonce值
        AccountBalance accountBalance = legderTools.getBalanceAndNonce(config.getChainId(), account.getAddress(), config.getChainId(), assetsId);
        byte[] nonce = RPCUtil.decode(accountBalance.getNonce());
        byte locked = 0;
        CoinFrom coinFrom = new CoinFrom(ma.getAddress(), config.getChainId(), assetsId, config.getuserRegistFee(), nonce, locked);
        CoinTo coinTo = new CoinTo(AddressTool.getAddress(Constant.BLACK_HOLE_ADDRESS), config.getChainId(), assetsId, config.getuserRegistFee());
        int txSize = tx.size() + coinFrom.size() + coinTo.size() + P2PHKSignature.SERIALIZE_LENGTH;
        //计算手续费
        BigInteger fee = TransactionFeeCalculator.getNormalTxFee(txSize);
        //总费用为
        BigInteger totalAmount = config.getuserRegistFee().add(fee);
        coinFrom.setAmount(totalAmount);
        //检查余额是否充足
        BigInteger mainAsset = accountBalance.getAvailable();
        //余额不足
        if (BigIntegerUtils.isLessThan(mainAsset, totalAmount)) {
            throw new NulsRuntimeException(CommonCodeConstanst.FAILED, "insufficient fee");
        }
        CoinData coinData = new CoinData();
        coinData.setFrom(Arrays.asList(coinFrom));
        coinData.setTo(Arrays.asList(coinTo));
        tx.setCoinData(coinData.serialize());
        //计算交易数据摘要哈希
        tx.setHash(NulsHash.calcHash(tx.serializeForHash()));
        return tx;
    }

    private boolean validUserName(String mailAddress) {
        return StringUtils.isNotBlank(mailAddress) && mailAddress.trim().length() < 50;
    }

}
