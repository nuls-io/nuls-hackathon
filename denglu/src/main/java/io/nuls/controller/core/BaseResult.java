package io.nuls.controller.core;

/**
 * @Author: zhoulijun
 * @Time: 2019-03-20 11:43
 * @Description: 功能描述
 */

public class BaseResult {

    Integer code;
    
    String msg;
    
    public BaseResult() {
    }

    public BaseResult(Integer code, String msg){
        this.code = code;
        this.msg = msg;
    }

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    @Override
    public String toString() {
        return new StringBuilder("{")
                .append("\"code\":")
                .append(code)
                .append(",\"msg\":\"")
                .append(msg).append('\"')
                .append('}').toString();
    }

}
