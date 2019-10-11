package com.green.pojo;

import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class Result {

    Integer code;
    String status;
    List<Message> datas;

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<Message> getDatas() {
        return datas;
    }

    public void setDatas(List<Message> datas) {
        this.datas = datas;
    }
}
