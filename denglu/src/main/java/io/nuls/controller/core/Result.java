package io.nuls.controller.core;

/**
 * @Author: zhoulijun
 * @Time: 2019-03-20 11:43
 * @Description: 功能描述
 */

public class Result extends BaseResult{

    Object data;
    
    public Result() {
    }

    public Result(Object data){ //Result的构造函数
        this.data = data;
        this.code = 1;
        this.msg = "SUCCESS";
    }
    
    public Result(Integer code, String msg){
        this.code = code;
        this.msg = msg;
    }

    public Result(Integer code, String msg, Object data){
        this.code = code;
        this.msg = msg;
        this.data = data;
    }
    
	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
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
                .append(",\"data\":")
                .append(data)
                .append('}').toString();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Result)) return false;

        Result that = (Result) o;

        if (code != that.code) return false;
        if (data != null ? !data.equals(that.data) : that.data != null) return false;
        return msg != null ? msg.equals(that.msg) : that.msg == null;
    }

    @Override
    public int hashCode() {
        int result = (code == 1 ? 1 : 0);
        result = 31 * result + (data != null ? data.hashCode() : 0);
        result = 31 * result + (msg != null ? msg.hashCode() : 0);
        return result;
    }
    
}
