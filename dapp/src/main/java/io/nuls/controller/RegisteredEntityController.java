package io.nuls.controller;

import io.nuls.Config;
import io.nuls.Constant;
import io.nuls.base.RPCUtil;
import io.nuls.base.basic.AddressTool;
import io.nuls.base.basic.TransactionFeeCalculator;
import io.nuls.base.data.*;
import io.nuls.base.signture.P2PHKSignature;
import io.nuls.controller.core.BaseController;
import io.nuls.controller.core.Result;
import io.nuls.controller.vo.Company;
import io.nuls.controller.vo.Person;
import io.nuls.controller.vo.RegisteredEntityData;
import io.nuls.core.constant.CommonCodeConstanst;
import io.nuls.core.core.annotation.Autowired;
import io.nuls.core.core.annotation.Component;
import io.nuls.core.exception.NulsException;
import io.nuls.core.exception.NulsRuntimeException;
import io.nuls.core.log.Log;
import io.nuls.core.model.BigIntegerUtils;
import io.nuls.core.model.StringUtils;
import io.nuls.core.rpc.util.NulsDateUtils;
import io.nuls.rpc.AccountTools;
import io.nuls.rpc.LegderTools;
import io.nuls.rpc.TransactionTools;
import io.nuls.rpc.vo.Account;
import io.nuls.rpc.vo.AccountBalance;
import io.nuls.service.RegisteredEntityService;
import io.nuls.service.dto.RegisteredEntity;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.io.IOException;
import java.math.BigInteger;
import java.util.Arrays;

/**
 * @Author: zhoulijun
 * @Time: 2019-06-11 21:03
 * @Description: 功能描述
 */
@Path("/")
@Component
public class RegisteredEntityController implements BaseController {


    @Autowired
    Config config;

    @Autowired
    AccountTools accountTools;

    @Autowired
    LegderTools legderTools;

    @Autowired
    TransactionTools transactionTools;

    @Autowired
    RegisteredEntityService registeredEntityService;

    /**
     *
     * @param req
     * @return
     */
    @Path("createRegisteredEntity")
    @Produces(MediaType.APPLICATION_JSON)
    @POST
    public Result<String> createRegisteredEntity(RegisteredEntityData req)  {
        return call(() -> {
            Log.debug("******* getUsername: " + req.getUsername());
            Transaction tx = null;
            int chainId = config.getChainId();
            if (!AddressTool.validAddress(chainId, req.getAddress())) {
                throw new NulsRuntimeException(CommonCodeConstanst.PARAMETER_ERROR);
            }
            if (!validAddress(req.getAddress())) {
                throw new NulsRuntimeException(CommonCodeConstanst.PARAMETER_ERROR);
            }
            //验证账户有效性
            accountTools.accountValid(config.getChainId(), req.getAddress(), req.getPassword());
            Account account = accountTools.getAccountByAddress(req.getAddress());
            if (registeredEntityService.hasUsername(req.getUsername())) {
                throw new NulsRuntimeException(CommonCodeConstanst.FAILED, "getUsername already in : " + req.getUsername());
            }
            tx = createRegisteredEntityTrasactionWithoutSign(account, req);
            //签名别名交易
            signTransaction(tx, account, req.getPassword());

            if (!transactionTools.newTx(tx)) {
                throw new NulsRuntimeException(CommonCodeConstanst.FAILED);
            }
            return new Result<>(tx.getHash().toHex());
        });
    }

    private Transaction createRegisteredEntityTrasactionWithoutSign(Account account, RegisteredEntityData entity) throws NulsException, IOException {
        Log.debug("******* createRegisteredEntityTrasactionWithoutSign: " + entity.toString());
        Transaction tx = null;
        tx = new Transaction();
        tx.setType(Constant.TX_TYPE_ONCHAIN_REGISTER);
        tx.setTime(NulsDateUtils.getCurrentTimeSeconds());
        RegisteredEntity ma = new RegisteredEntity();
        ma.setPerson(new Person());
        ma.setCompany(new Company());
        ma.setAddress(AddressTool.getAddress(account.getAddress()));

        ma.setAuthorization(entity.getAuthorization());
        ma.setUsername(entity.getUsername());
        ma.setUserType(entity.getUserType());
        ma.setRegisterationTime(entity.getRegisterationTime());
        ma.setProxyPlatformID(entity.getProxyPlatformID());

        ma.getPerson().setName(entity.getPerson().getName());
        ma.getPerson().setGender(entity.getPerson().getGender());
        ma.getPerson().setId(entity.getPerson().getId());
        ma.getPerson().setPhoneNum(entity.getPerson().getPhoneNum());
        ma.getPerson().setAddress(entity.getPerson().getAddress());
        ma.getPerson().setNation(entity.getPerson().getNation());

        ma.getCompany().setName(entity.getCompany().getName());
        ma.getCompany().setCreditCode(entity.getCompany().getCreditCode());
        ma.getCompany().setContactPerson(entity.getCompany().getContactPerson());
        ma.getCompany().setContactPhone(entity.getCompany().getContactPhone());

        tx.setTxData(ma.serialize());
        //设置别名烧毁账户所属本链的主资产
        int assetsId = config.getAssetId();
        //查询账本获取nonce值
        AccountBalance accountBalance = legderTools.getBalanceAndNonce(config.getChainId(), account.getAddress(), config.getChainId(), assetsId);
        byte[] nonce = RPCUtil.decode(accountBalance.getNonce());
        byte locked = 0;
        CoinFrom coinFrom = new CoinFrom(ma.getAddress(), config.getChainId(), assetsId, config.getStandardFee(), nonce, locked);
        CoinTo coinTo = new CoinTo(AddressTool.getAddress(Constant.BLACK_HOLE_ADDRESS), config.getChainId(), assetsId, config.getStandardFee());
        int txSize = tx.size() + coinFrom.size() + coinTo.size() + P2PHKSignature.SERIALIZE_LENGTH;
        //计算手续费
        BigInteger fee = TransactionFeeCalculator.getNormalTxFee(txSize);
        //总费用为
        BigInteger totalAmount = config.getStandardFee().add(fee);
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

    private boolean validAddress(String ddress) {
        return StringUtils.isNotBlank(ddress) && ddress.trim().length() < 50;
    }

    /**
     * 获取指定用户的注册实体
     *
     * @param username
     * @return
     */
    @Path("getRegisteredEntity/{username}")
    @Produces(MediaType.APPLICATION_JSON)
    @GET
    public Result<RegisteredEntityData> getRegisteredEntity(@PathParam("username") String username) {
        return call(()-> new Result(registeredEntityService.getRegisteredEntity(username).get()));
    }
}
