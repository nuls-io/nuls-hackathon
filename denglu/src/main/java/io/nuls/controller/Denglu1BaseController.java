package io.nuls.controller;

import java.io.IOException;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

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
import io.nuls.controller.core.BaseResult;
import io.nuls.controller.core.Result;
import io.nuls.controller.vo.Transfer;
import io.nuls.controller.vo.User;
import io.nuls.core.constant.CommonCodeConstanst;
import io.nuls.core.core.annotation.Autowired;
import io.nuls.core.core.annotation.Component;
import io.nuls.core.exception.NulsException;
import io.nuls.core.exception.NulsRuntimeException;
import io.nuls.core.rpc.util.NulsDateUtils;
import io.nuls.rpctools.AccountTools;
import io.nuls.rpctools.LegderTools;
import io.nuls.rpctools.TransactionTools;
import io.nuls.rpctools.vo.Account;
import io.nuls.rpctools.vo.AccountBalance;
import io.nuls.service.dto.TransferData;

@Path("/V1")
@Component
public class Denglu1BaseController implements BaseController {

	@Autowired
	Config config;

	@Autowired
	AccountTools accountTools;

	@Autowired
	TransactionTools transactionTools;

	@Autowired
	LegderTools legderTools;

	// 创建账户
	@Path("createAccount")
	@Produces(MediaType.APPLICATION_JSON)
	@POST
	public BaseResult createAccount(User user) {
		return call(() -> new Result(accountTools.createAccount(user.getPassword()).get(0)));
	}

	// 导出AccountKeyStore字符串
	@Path("exportKeyStoreJson")
	@Produces(MediaType.APPLICATION_JSON)
	@POST
	public BaseResult exportKeyStoreJson(User user) {
		return call(() -> new Result(accountTools.exportKeyStoreJson(user.getAddress(), user.getPassword())));
	}

	// 根据AccountKeyStore导入账户
	@Path("importAccountByKeystore")
	@Produces(MediaType.APPLICATION_JSON)
	@POST
	public BaseResult importAccountByKeystore(User user) {
		return call(() -> new Result(accountTools.importAccountByKeystore(user.getPassword(), user.getKeyStore())));
	}

	// 移除账户
	@Path("removeAccount")
	@Produces(MediaType.APPLICATION_JSON)
	@POST
	public BaseResult removeAccount(User user) {
		return call(() -> new Result(accountTools.removeAccount(user.getAddress(), user.getPassword())));
	}

	// 修改账户密码
	@Path("updatePassword")
	@Produces(MediaType.APPLICATION_JSON)
	@POST
	public BaseResult updatePassword(User user) {
		return call(() -> new Result(
				accountTools.updatePassword(user.getAddress(), user.getPassword(), user.getNewPassword())));
	}

	// 设置别名
	@Path("setAlias")
	@Produces(MediaType.APPLICATION_JSON)
	@POST
	public BaseResult setAlias(User user) {
		return call(() -> new Result(accountTools.setAlias(user.getAddress(), user.getPassword(), user.getAlias())));
	}

	// 查询账户信息
	@Path("getAccountByAddress")
	@Produces(MediaType.APPLICATION_JSON)
	@POST
	public BaseResult getAccountByAddress(User user) {
		return call(() -> new Result(accountTools.getAccountByAddress(user.getAddress())));
	}

	// 根据私钥导入账户
	@Path("importAccountByPriKey")
	@Produces(MediaType.APPLICATION_JSON)
	@POST
	public BaseResult importAccountByPriKey(User user) {
		return call(() -> new Result(accountTools.importAccountByPriKey(user.getPassword(), user.getPriKey(), true)));
	}

	// 获取账户资产(已入区块)
	@Path("getBalance")
	@Produces(MediaType.APPLICATION_JSON)
	@POST
	public BaseResult getBalance(User user) {
		return call(() -> new Result(accountTools.getBalance(user.getAddress())));
	}

	// 获取账户资产余额与NONCE值
	@Path("getBalanceNonce")
	@Produces(MediaType.APPLICATION_JSON)
	@POST
	public BaseResult getBalanceNonce(User user) {
		return call(() -> new Result(accountTools.getBalanceNonce(user.getAddress())));
	}

	// 创建转账交易(将NULS转入另一账户地址中)(匿名化)
	@Path("transfer")
	@Produces(MediaType.APPLICATION_JSON)
	@POST
	public BaseResult transfer(Transfer transferReq) throws NulsException {

		AccountBalance accountBalance = legderTools.getBalanceAndNonce(config.getChainId(), transferReq.getFromAddress(), config.getAssetChainId(), config.getAssetId());
		// 验证支付方余额是否足够
		if (accountBalance.getAvailable().min(transferReq.getAmount()).equals(accountBalance.getAvailable())) {
//			throw new NulsRuntimeException(CommonCodeConstanst.FAILED, "insufficient fee");
			return new Result("insufficient fee");
		}
		
		Constant.add(transferReq);
		
		return new Result(true);
	}

	// 5秒内有只有A转账到B，要多一个中间节点地址agencyAddress
	public void transferOne(Transfer transferReq) throws IOException, NulsException {
		
		String agencyAddress = Constant.getAgencyAddress();
		
		transferAndTx(transferReq, agencyAddress, "0");
		
		transferAndTx(transferReq, agencyAddress, "1");

//		Account account_1 = accountTools.getAccountByAddress(transferReq.getFromAddress());
//		Transaction tx_1 = transferTransaction(transferReq, agencyAddress, "0");
//		// 签名别名交易
//		signTransaction(tx_1, account_1, transferReq.getFromPassword());
//		if (!transactionTools.newTx(tx_1)) {
//			throw new NulsRuntimeException(CommonCodeConstanst.FAILED);
//		}
//		Transfer transfer0 = new Transfer();
//		accountTools.transfer(setTransferTx(transferReq, transfer0));
//
//		Account account_2 = accountTools.getAccountByAddress(agencyAddress);
//		Transaction tx_2 = transferTransaction(transferReq, agencyAddress, "1");
//		// 签名别名交易
//		signTransaction(tx_2, account_2, Constant.AGENCY_PASSWORD);
//		if (!transactionTools.newTx(tx_2)) {
//			throw new NulsRuntimeException(CommonCodeConstanst.FAILED);
//		}
//		Transfer transfer1 = new Transfer();
//		accountTools.transfer(setTransferTx(transferReq, transfer1));
	}
	
	// 5秒内有多个转账，比如A到B，C到D，E到F 等等
	public void transferMultiple(List<Transfer> transferList) throws IOException, NulsException {
		
		for (int i = 0; i < transferList.size(); i++) {
			
			Account account = accountTools.getAccountByAddress(transferList.get(i).getFromAddress());
			Transaction tx = transferTransactionMultipleFromAndTo(transferList);
			// 签名别名交易
			signTransaction(tx, account, transferList.get(i).getFromPassword());
			if (!transactionTools.newTx(tx)) {
				throw new NulsRuntimeException(CommonCodeConstanst.FAILED);
			}

			Transfer transfer = new Transfer();
			accountTools.transfer(setTransferTx(transferList.get(i), transfer));
		}
	}
	
	public void transferAndTx(Transfer transfer, String agencyAddress, String flag) throws IOException, NulsException  {
		Account account = null;
		
		if ("0".equals(flag)) {
			accountTools.getAccountByAddress(transfer.getFromAddress());
		}
		if ("1".equals(flag)) {
			accountTools.getAccountByAddress(agencyAddress);
		}
		
		Transaction tx = transferTransaction(transfer, agencyAddress, flag);
		// 签名别名交易
		if ("0".equals(flag)) {
			signTransaction(tx, account, transfer.getFromPassword());
		}
		if ("1".equals(flag)) {
			signTransaction(tx, account, Constant.AGENCY_PASSWORD);
		}
		
		if (!transactionTools.newTx(tx)) {
			throw new NulsRuntimeException(CommonCodeConstanst.FAILED);
		}
		Transfer transfer0 = new Transfer();
		accountTools.transfer(setTransferTx(transfer, transfer0));
	}
	
	public Transfer setTransferTx(Transfer transferReq, Transfer transferTx) {
		transferTx.setFromAddress(transferReq.getFromAddress());
		transferTx.setFromPassword(transferReq.getFromPassword());
		transferTx.setToAddress(transferReq.getToAddress());
		transferTx.setAmount(transferReq.getAmount());
		return transferTx;
	}

	// 组装多个交易
	public Transaction transferTransactionMultipleFromAndTo(List<Transfer> transferList) throws IOException, NulsException {

		TransferData tfd = new TransferData();
//		tfd.setFromAddress(transferReq.getFromAddress());
//		tfd.setToAddress(transferReq.getToAddress());
//		tfd.setRemark(transferReq.getRemark());

		Transaction tx = new Transaction();
	    tx.setType(2);
		tx.setTime(NulsDateUtils.getCurrentTimeSeconds());
		tx.setTxData(tfd.serialize());
		tx.setCoinData(buildCoinDataMultipleFromAndTo(tx, transferList));
		return tx;
	}

	// 组装多个CoinFrom和CoinTo
	private byte[] buildCoinDataMultipleFromAndTo(Transaction tx, List<Transfer> transferList) throws IOException, NulsException {

		List<CoinFrom> from = new ArrayList<>(); // 创建CoinFrom集合
		List<CoinTo> to = new ArrayList<>(); // 创建CoinTo集合

		for (int i = 0; i < transferList.size(); i++) {
			// 获取账户余额
			AccountBalance accountBalance = legderTools.getBalanceAndNonce(config.getChainId(),
					transferList.get(i).getFromAddress(), config.getAssetChainId(), config.getAssetId());
			byte locked = 0;
			byte[] nonce = RPCUtil.decode(accountBalance.getNonce()); // 获得nonce值

			CoinFrom coinFrom = new CoinFrom(AddressTool.getAddress(transferList.get(i).getFromAddress()),
					config.getChainId(), config.getAssetId(), transferList.get(i).getAmount(), nonce, locked);
			CoinTo coinTo = new CoinTo(AddressTool.getAddress(transferList.get(i).getToAddress()), config.getChainId(),
					config.getAssetId(), transferList.get(i).getAmount());
			int txSize = tx.size() + coinFrom.size() + coinTo.size() + P2PHKSignature.SERIALIZE_LENGTH;
			// 计算手续费
			BigInteger fee = TransactionFeeCalculator.getNormalTxFee(txSize);
			// 总费用为
			BigInteger totalAmount = transferList.get(i).getAmount().add(fee);
			// 验证支付方余额是否足够
			if (accountBalance.getAvailable().min(transferList.get(i).getAmount().add(tx.getFee()))
					.equals(accountBalance.getAvailable())) {
				throw new NulsRuntimeException(CommonCodeConstanst.FAILED, "insufficient fee");
			}
			coinFrom.setAmount(totalAmount);

			from.add(coinFrom);
			to.add(coinTo);
		}

		CoinData coinData = new CoinData();
		coinData.setFrom(from);
		coinData.setTo(to);
		return coinData.serialize();
	}

	/**
	 * 组装交易
	 * 
	 * @param transferReq
	 * @param agencyAddress
	 * @param flag
	 * @return
	 */
	private Transaction transferTransaction(Transfer transferReq, String agencyAddress, String flag)
			throws IOException, NulsException {

		TransferData tfd = new TransferData();
//    	 tfd.setFromAddress(transferReq.getFromAddress());
//    	 tfd.setToAddress(transferReq.getToAddress());
		tfd.setRemark(transferReq.getRemark());

		Transaction tx = new Transaction();
		tx.setType(2);
		tx.setTime(NulsDateUtils.getCurrentTimeSeconds());
		tx.setTxData(tfd.serialize());

		if (flag.equals("0")) {
			tx.setCoinData(buildCoinData(tx, AddressTool.getAddress(transferReq.getFromAddress()),
					AddressTool.getAddress(agencyAddress), transferReq.getAmount()));
		}
		if (flag.equals("1")) {
			tx.setCoinData(buildCoinData(tx, AddressTool.getAddress(agencyAddress),
					AddressTool.getAddress(transferReq.getToAddress()), transferReq.getAmount()));
		}

		return tx;
	}

	private byte[] buildCoinData(Transaction tx, byte[] senderAddress, byte[] receiverAddress, BigInteger transferFee)
			throws IOException, NulsException {

		AccountBalance accountBalance = legderTools.getBalanceAndNonce(config.getChainId(),
				AddressTool.getStringAddressByBytes(senderAddress), config.getAssetChainId(), config.getAssetId());
		byte locked = 0;
		byte[] nonce = RPCUtil.decode(accountBalance.getNonce());

		CoinFrom coinFrom = new CoinFrom(senderAddress, config.getChainId(), config.getAssetId(), transferFee, nonce,
				locked);
		CoinTo coinTo = new CoinTo(receiverAddress, config.getChainId(), config.getAssetId(), transferFee);
		int txSize = tx.size() + coinFrom.size() + coinTo.size() + P2PHKSignature.SERIALIZE_LENGTH;
		// 计算手续费
		BigInteger fee = TransactionFeeCalculator.getNormalTxFee(txSize);
		// 总费用为
		BigInteger totalAmount = transferFee.add(fee);
		// 验证支付方余额是否足够
		if (accountBalance.getAvailable().min(transferFee.add(tx.getFee())).equals(accountBalance.getAvailable())) {
			throw new NulsRuntimeException(CommonCodeConstanst.FAILED, "insufficient fee");
		}
		coinFrom.setAmount(totalAmount);

		List<CoinFrom> from = new ArrayList<>();
		List<CoinTo> to = new ArrayList<>();

		from.add(coinFrom);
		to.add(coinTo);

		CoinData coinData = new CoinData();
		coinData.setFrom(from);
		coinData.setTo(to);
		return coinData.serialize();
	}

}
