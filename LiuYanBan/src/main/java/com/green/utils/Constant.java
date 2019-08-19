package com.green.utils;

import org.springframework.stereotype.Component;

@Component
public class Constant {
    public final static Integer ERROR_STATUS = 20000;
    public final static Integer SUCCESS_STATUS = 20000;

    /**
     * 创建用户名的交易类型
     */
    public static final int TX_TYPE_CREATE_USER_ADDRESS = 20001;

    /**
     * 发送留言的交易类型
     */
    public static final int TX_TYPE_SEND_MESSAGE = 20002;

    /**
     * 黑洞地址
     * 用于接收系统收费
     */
    public static final String BLACK_HOLE_ADDRESS = "tNULSeBaMtsumpXhfEZBU2pMEz7SHLcx5b2TQr";

}
