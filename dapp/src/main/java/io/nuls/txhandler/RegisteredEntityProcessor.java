package io.nuls.txhandler;

import io.nuls.Config;
import io.nuls.Constant;
import io.nuls.base.basic.AddressTool;
import io.nuls.base.basic.NulsByteBuffer;
import io.nuls.base.data.*;
import io.nuls.controller.vo.Company;
import io.nuls.controller.vo.Person;
import io.nuls.controller.vo.RegisteredEntityData;
import io.nuls.core.core.annotation.Autowired;
import io.nuls.core.core.annotation.Component;
import io.nuls.core.exception.NulsException;
import io.nuls.core.log.Log;
import io.nuls.rpc.LegderTools;
import io.nuls.rpc.vo.AccountBalance;
import io.nuls.service.RegisteredEntityService;
import io.nuls.service.dto.RegisteredEntity;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * @Author: zhoulijun
 * @Time: 2019-06-11 20:00
 * @Description: 邮件地址存储交易处理器
 */
@Component
public class RegisteredEntityProcessor implements TransactionProcessor {

    @Autowired
    RegisteredEntityService registeredEntityService;

    @Autowired
    LegderTools legderTools;

    @Autowired
    Config config;

    @Override
    public int getType() {
        return Constant.TX_TYPE_ONCHAIN_REGISTER;
    }

    @Override
    public boolean validate(int chainId, Transaction tx, BlockHeader blockHeader) {
        Log.debug("******* validate tx *******" + tx.toString());

        //验证交易hash是否一致
        try {
            NulsHash nulsHash = NulsHash.calcHash(tx.serializeForHash());
            if (!nulsHash.equals(tx.getHash())) {
                return false;
            }
            RegisteredEntity registeredEntity = new RegisteredEntity();
            registeredEntity.setCompany(new Company());
            registeredEntity.setPerson(new Person());

            registeredEntity.parse(new NulsByteBuffer(tx.getTxData()));

            if(registeredEntityService.hasUsername(registeredEntity.getUsername())){
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
    public boolean commit(int chainId, Transaction tx, BlockHeader blockHeader) {

        //版权实体与公钥的对应关系
        Log.info("commit tx:" + tx.toString());
        //        throw new
        RegisteredEntity registeredEntity = new RegisteredEntity();
        Person p = new Person();
        Company company = new Company();
        registeredEntity.setPerson(p);
        registeredEntity.setCompany(company);
        try {
            RegisteredEntityData registeredEntityData = new RegisteredEntityData();
            registeredEntityData.setPerson(new Person());
            registeredEntityData.setCompany(new Company());
            registeredEntity.parse(new NulsByteBuffer(tx.getTxData()));
            registeredEntityData.setAddress(AddressTool.getStringAddressByBytes(registeredEntity.getAddress()));
            registeredEntityData.setAuthorization(registeredEntity.getAuthorization());
            registeredEntityData.setUsername(registeredEntity.getUsername());
            registeredEntityData.setUserType(registeredEntity.getUserType());
            registeredEntityData.setRegisterationTime(registeredEntity.getRegisterationTime());
            registeredEntityData.setProxyPlatformID(registeredEntity.getProxyPlatformID());

            registeredEntityData.getPerson().setName(registeredEntity.getPerson().getName());
            registeredEntityData.getPerson().setGender(registeredEntity.getPerson().getGender());
            registeredEntityData.getPerson().setId(registeredEntity.getPerson().getId());
            registeredEntityData.getPerson().setPhoneNum(registeredEntity.getPerson().getPhoneNum());
            registeredEntityData.getPerson().setAddress(registeredEntity.getPerson().getAddress());
            registeredEntityData.getPerson().setNation(registeredEntity.getPerson().getNation());

            registeredEntityData.getCompany().setName(registeredEntity.getCompany().getName());
            registeredEntityData.getCompany().setCreditCode(registeredEntity.getCompany().getCreditCode());
            registeredEntityData.getCompany().setContactPerson(registeredEntity.getCompany().getContactPerson());
            registeredEntityData.getCompany().setContactPhone(registeredEntity.getCompany().getContactPhone());
            registeredEntityService.saveRegisteredEntity(registeredEntityData);
        } catch (NulsException e) {
            e.printStackTrace();
        }
        return true;
    }

    @Override
    public boolean rollback(int chainId, Transaction tx, BlockHeader blockHeader) {
        //删除邮件地址与公钥的对应关系
        Log.info("rollback tx");
        RegisteredEntity registeredEntity = new RegisteredEntity();
        try {
            registeredEntity.parse(new NulsByteBuffer(tx.getTxData()));
            registeredEntityService.removeRegisteredEntity(registeredEntity.getUsername());
        } catch (NulsException e) {
            e.printStackTrace();
        }

        return true;
    }
}
