package io.nuls;

/**
 * @Description: 自定义响应状态枚举
 */
public enum StatusEnum {
	
	error(1, "ERROR"),
	ac_0017(201, "The password format wrong"), 
	err_0012(202, "Parameter error"),
	err_0013(203, "Parameter can not be null"), 
	unknown(204, "System error: Unknown"), 
	ac_0000(205, "Password is wrong"), 
	ac_0004(206, "Address wrong"),
	ac_0001(207, "Account does not exist"),
	ac_0029(208, "Insufficient fee"),
	ac_0016(209, "The alias format wrong"),
	err_0002(210, "Server-side processing failed"),
	ac_0028(211, "Insufficient balance"),
	ac_0006(212, "Alias is not exist"),
	ac_0012(213, "The private key is wrong"),
	ac_0003(214, "Account already exists"),
	ac_0015(215, "The AccountKeystore file was damaged");
	

	public final Integer code;
	public final String msg;

	StatusEnum(Integer code, String msg) {
		this.code = code;
		this.msg = msg;
	}

	public Integer getCode() {
		return code;
	}

	public static String getMsgByKey(Integer code) {
		for (StatusEnum type : StatusEnum.values()) {
			if (type.getCode() == code) {
				return type.msg;
			}
		}
		return null;
	}

}
