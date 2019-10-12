package io.nuls.rpctools;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

import cn.hutool.core.util.CharsetUtil;
import cn.hutool.core.util.HexUtil;
import io.nuls.Config;
import io.nuls.controller.vo.Transfer;
import io.nuls.core.core.annotation.Autowired;
import io.nuls.core.core.annotation.Component;
import io.nuls.core.exception.NulsException;
import io.nuls.core.parse.MapUtils;
import io.nuls.core.rpc.info.Constants;
import io.nuls.core.rpc.model.ModuleE;
import io.nuls.rpctools.vo.Account;
import io.nuls.rpctools.vo.AccountBalance;
import io.nuls.rpctools.vo.Balance;
import io.nuls.rpctools.vo.TransactionData;

/**
 * @Author: zhoulijun
 * @Time: 2019-06-12 14:06
 * @Description: 功能描述
 */
@Component
public class AccountTools implements CallRpc {

    @Autowired
    Config config;

    
    // 创建账号
    @SuppressWarnings("unchecked")
	public List<String> createAccount(String password) {
    	Map<String, Object> param = new HashMap<>(3);
    	param.put("chainId", config.getChainId());
    	param.put("count", 1);
    	param.put("password", password);
    	
    	return callRpc(ModuleE.AC.name, "ac_createAccount", param, (Function<Map<String, Object>, List<String>>) res -> (List<String>) res.get("list"));
    }
    
    // 导出AccountKeyStore字符串
	public String exportKeyStoreJson(String address, String password) {
    	Map<String, Object> param = new HashMap<>(3);
    	param.put("chainId", config.getChainId());
    	param.put("address", address);
    	param.put("password", password);
    	
    	return callRpc(ModuleE.AC.name, "ac_exportKeyStoreJson", param, (Function<Map<String, Object>, String>) res -> (String) res.get("keystore"));
    }
	
	// 根据AccountKeyStore导入账户
	public String importAccountByKeystore(String password, String keyStore) {
	    Map<String, Object> param = new HashMap<>(4);
	    param.put("chainId", config.getChainId());
	    param.put("password", password);
	    param.put("keyStore", HexUtil.encodeHexStr(keyStore, CharsetUtil.CHARSET_UTF_8));
	    param.put("overwrite", true);
	    	
	    return callRpc(ModuleE.AC.name, "ac_importAccountByKeystore", param, (Function<Map<String, Object>, String>) res -> (String) res.get("address"));
	}
    
    // 移除账户
    public Boolean removeAccount(String address, String password) {
    	Map<String, Object> param = new HashMap<>(3);
    	param.put("chainId", config.getChainId());
    	param.put("address", address);
    	param.put("password", password);
    	
    	return callRpc(ModuleE.AC.name, "ac_removeAccount", param, (Function<Map<String, Object>, Boolean>) res -> (Boolean) res.get("value"));
    }
    
    // 修改账户密码
    public Boolean updatePassword(String address, String password, String newPassword) {
    	Map<String, Object> param = new HashMap<>(4);
    	param.put("chainId", config.getChainId());
    	param.put("address", address);
    	param.put("password", password);
    	param.put("newPassword", newPassword);
    	
    	return callRpc(ModuleE.AC.name, "ac_updatePassword", param, (Function<Map<String, Object>, Boolean>) res -> (Boolean) res.get("value"));
    }
    
    // 设置别名
    public String setAlias(String address, String password, String alias) {
    	Map<String, Object> param = new HashMap<>(4);
    	param.put("chainId", config.getChainId());
    	param.put("address", address);
    	param.put("password", password);
    	param.put("alias", alias);
    	
    	return callRpc(ModuleE.AC.name, "ac_setAlias", param, (Function<Map<String, Object>, String>) res -> (String) res.get("txHash"));
    }
    
    // 查询账户信息
    public Account getAccountByAddress(String address) {
        Map<String, Object> param = new HashMap<>(2);
        param.put("chainId", config.getChainId());
        param.put("address", address);
        return callRpc(ModuleE.AC.name, "ac_getAccountByAddress", param, (Function<Map<String, Object>, Account>) res -> {
                    if (res == null) {
                        return null;
                    }
                    return MapUtils.mapToBean(res, new Account());
                }
        );
    }
    
    // 根据私钥导入账户
    public String importAccountByPriKey(String password, String priKey, boolean overwrite) {
    	Map<String, Object> param = new HashMap<>(4);
    	param.put("chainId", config.getChainId());
    	param.put("password", password);
    	param.put("priKey", priKey);
    	param.put("overwrite", overwrite);
    	return callRpc(ModuleE.AC.name, "ac_importAccountByPriKey", param, (Function<Map<String, Object>, String>) res -> (String) res.get("address"));
    }
    
    // 获取账户资产(已入区块)
    public Balance getBalance(String address) {
        Map<String, Object> param = new HashMap<>(2);
        param.put("chainId", config.getChainId());
        param.put("assetChainId", config.getAssetChainId());
        param.put("assetId", config.getAssetId());
        param.put("address", address);
        return callRpc(ModuleE.LG.abbr, "getBalance", param, (Function<Map<String, Object>, Balance>) res -> {
                    if (res == null) {
                        return null;
                    }
                    
                    Balance balance = new Balance();
                    balance.setTotal((Integer) res.get("total"));
                    balance.setFreeze((Integer) res.get("freeze"));
                    balance.setAvailable((Integer) res.get("available"));
                    
                    return balance;
                }
        );
    }
    
    // 获取账户资产余额与NONCE值
    public AccountBalance getBalanceNonce(String address) {
        Map<String, Object> param = new HashMap<>(2);
        param.put("chainId", config.getChainId());
        param.put("assetChainId", config.getAssetChainId());
        param.put("assetId", config.getAssetId());
        param.put("address", address);
        return callRpc(ModuleE.LG.abbr, "getBalanceNonce", param, (Function<Map<String, Object>, AccountBalance>) res -> {
                    if (res == null) {
                        return null;
                    }
                    
                    AccountBalance accountBalance = new AccountBalance();
                    accountBalance.setNonce((String) res.get("nonce"));
                    accountBalance.setNonceType((Integer) res.get("nonceType"));
                    accountBalance.setAvailable(new BigInteger((String.valueOf(res.get("available")))));
                    accountBalance.setPermanentLocked(new BigInteger((String.valueOf(res.get("permanentLocked")))));
                    accountBalance.setTimeHeightLocked(new BigInteger((String.valueOf(res.get("timeHeightLocked")))));
                    
                    return accountBalance;
                }
        );
    }
    
    // 创建转账交易(将NULS转入另一账户地址中)
    public String transfer(Transfer transfer) {
    	
    	List<TransactionData> inputs = new ArrayList<TransactionData>();
    	TransactionData td0 = new TransactionData();
    	td0.setAddress(transfer.getFromAddress());
//    	td0.setAssetsChainId(transfer.getFromAssetsChainId());
//    	td0.setAssetsId(transfer.getFromAssetsId());
    	td0.setAssetsChainId(config.getAssetChainId());
    	td0.setAssetsId(config.getAssetId());
    	td0.setAmount(transfer.getAmount());
    	td0.setPassword(transfer.getFromPassword());
    	inputs.add(td0);
    	
    	List<TransactionData> outputs = new ArrayList<TransactionData>();
    	TransactionData td1 = new TransactionData();
    	td1.setAddress(transfer.getToAddress());
//    	td1.setAssetsChainId(transfer.getToAssetsChainId());
//    	td1.setAssetsId(transfer.getToAssetsId());
    	td1.setAssetsChainId(config.getAssetChainId());
    	td1.setAssetsId(config.getAssetId());
    	td1.setAmount(transfer.getAmount());
    	td1.setPassword(transfer.getFromPassword());
    	outputs.add(td1);
    	
    	Map<String, Object> param = new HashMap<>(4);
    	param.put("chainId", config.getChainId());
    	param.put("inputs", inputs);
    	param.put("outputs", outputs);
    	param.put("remark", transfer.getRemark());

    	return callRpc(ModuleE.AC.name, "ac_transfer", param, (Function<Map<String, Object>, String>) res -> (String) res.get("value"));
    }
    
    //获取账户私钥
    public String getPriKeyByAddress( String address, String password) throws NulsException {
        Map<String, Object> param = new HashMap<>(4);
        param.put("chainId", config.getChainId());
        param.put("address", address);
        param.put("password", password);
        return callRpc(ModuleE.AC.abbr, "ac_getPriKeyByAddress", param, (Function<Map<String, Object>, String>) res -> (String) res.get("priKey"));
    }
    
    /**
     * 账户验证
     * account validate
     *
     * @param chainId
     * @param address
     * @param password
     * @return validate result
     */
    public boolean accountValid(int chainId, String address, String password) throws NulsException {
        Map<String, Object> callParams = new HashMap<>(4);
        callParams.put(Constants.CHAIN_ID, chainId);
        callParams.put("address", address);
        callParams.put("password", password);
        return callRpc(ModuleE.AC.abbr, "ac_getPriKeyByAddress", callParams, (Function<Map<String, Object>, Boolean>) res -> (Boolean) res.get("valid"));
    }

    /**
     * 获取账户私钥
     * account validate
     *
     * @param chainId
     * @param address
     * @param password
     * @return validate result
     */
    public String getAddressPriKey(int chainId, String address, String password) throws NulsException {
        Map<String, Object> callParams = new HashMap<>(4);
        callParams.put(Constants.CHAIN_ID, chainId);
        callParams.put("address", address);
        callParams.put("password", password);
        return callRpc(ModuleE.AC.abbr, "ac_getPriKeyByAddress", callParams, (Function<Map<String, Object>, String>) res -> (String) res.get("priKey"));
    }

}
