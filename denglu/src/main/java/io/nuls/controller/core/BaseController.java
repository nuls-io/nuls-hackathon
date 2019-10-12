package io.nuls.controller.core;

import java.io.IOException;

import io.nuls.StatusEnum;
import io.nuls.Utils;
import io.nuls.base.data.Transaction;
import io.nuls.core.exception.NulsException;
import io.nuls.core.exception.NulsRuntimeException;
import io.nuls.core.log.Log;
import io.nuls.rpctools.vo.Account;

/**
 * @Author: zhoulijun
 * @Time: 2019-06-13 16:35
 * @Description: 功能描述
 */
public interface BaseController {

	public interface Caller<T> {
		Result exec() throws Throwable;
	}

	@SuppressWarnings("rawtypes")
	default <T> BaseResult call(Caller caller) {
		try {
			return caller.exec();
		} catch (NulsException e) {
			Log.error(e);
			Log.error(e.getErrorCode().getCode());

			return new Result(1, e.getErrorCode().getMsg(), false);
		} catch (NulsRuntimeException e) {
			Log.error(e);
			Log.error(e.getCode());

			if ("ac_0017".equals(e.getCode())) {
				return new BaseResult(StatusEnum.ac_0017.code, StatusEnum.getMsgByKey(StatusEnum.ac_0017.code));

			} else if ("err_0012".equals(e.getCode())) {
				return new BaseResult(StatusEnum.err_0012.code, StatusEnum.getMsgByKey(StatusEnum.err_0012.code));

			} else if ("err_0013".equals(e.getCode())) {
				return new BaseResult(StatusEnum.err_0013.code, StatusEnum.getMsgByKey(StatusEnum.err_0013.code));

			} else if ("ac_0000".equals(e.getCode())) {
				return new BaseResult(StatusEnum.ac_0000.code, StatusEnum.getMsgByKey(StatusEnum.ac_0000.code));

			} else if ("ac_0004".equals(e.getCode())) {
				return new BaseResult(StatusEnum.ac_0004.code, StatusEnum.getMsgByKey(StatusEnum.ac_0004.code));

			} else if ("ac_0001".equals(e.getCode())) {
				return new BaseResult(StatusEnum.ac_0001.code, StatusEnum.getMsgByKey(StatusEnum.ac_0001.code));

			} else if ("ac_0029".equals(e.getCode())) {
				return new BaseResult(StatusEnum.ac_0029.code, StatusEnum.getMsgByKey(StatusEnum.ac_0029.code));

			} else if ("ac_0016".equals(e.getCode())) {
				return new BaseResult(StatusEnum.ac_0016.code, StatusEnum.getMsgByKey(StatusEnum.ac_0016.code));

			} else if ("err_0002".equals(e.getCode())) {
				return new BaseResult(StatusEnum.err_0002.code, StatusEnum.getMsgByKey(StatusEnum.err_0002.code));

			} else if ("ac_0028".equals(e.getCode())) {
				return new BaseResult(StatusEnum.ac_0028.code, StatusEnum.getMsgByKey(StatusEnum.ac_0028.code));

			} else if ("ac_0006".equals(e.getCode())) {
				return new BaseResult(StatusEnum.ac_0006.code, StatusEnum.getMsgByKey(StatusEnum.ac_0006.code));

			} else if ("ac_0012".equals(e.getCode())) {
				return new BaseResult(StatusEnum.ac_0012.code, StatusEnum.getMsgByKey(StatusEnum.ac_0012.code));

			} else if ("ac_0003".equals(e.getCode())) {
				return new BaseResult(StatusEnum.ac_0003.code, StatusEnum.getMsgByKey(StatusEnum.ac_0003.code));

			} else if ("ac_0015".equals(e.getCode())) {
				return new BaseResult(StatusEnum.ac_0015.code, StatusEnum.getMsgByKey(StatusEnum.ac_0015.code));

			} else {
				return new Result(StatusEnum.error.code, StatusEnum.getMsgByKey(StatusEnum.error.code), false);
			}
			
		} catch (Throwable e) {
			Log.error(e);

			if (e.getMessage() == null) {
				return new BaseResult(StatusEnum.unknown.code, StatusEnum.getMsgByKey(StatusEnum.unknown.code));
			}

			return new BaseResult(204, "System error: " + e.getMessage());
		}
	}

	default Transaction signTransaction(Transaction transaction, Account account, String password) throws IOException {
		return Utils.signTransaction(transaction, account.getEncryptedPrikeyHex(), account.getPubkeyHex(), password);
	}
}
