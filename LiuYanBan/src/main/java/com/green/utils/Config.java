package com.green.utils;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

import java.io.File;
import java.math.BigInteger;

/**
 * @Author: zhoulijun
 * @Time: 2019-06-12 13:53
 * @Description: 功能描述
 */
@Configuration
@Component
public class Config {

    /**
     * 当前运行的chain id 来自配置文件
     */
    private int chainId;

    /**
     * 默认资产id
     */
    private int assetId;

    /**
     * 注册用户手续费
     */
    private BigInteger userRegistFee;

    /**
     * 上传留言手续费
     */
    private BigInteger uploadMessageFee;

    private String dataPath;


    public int getChainId() {
        return chainId;
    }

    public void setChainId(int chainId) {
        this.chainId = chainId;
    }

    public int getAssetId() {
        return assetId;
    }

    public void setAssetId(int assetId) {
        this.assetId = assetId;
    }

    public BigInteger getuserRegistFee() {
        return userRegistFee;
    }

    public void setuserRegistFee(BigInteger userRegistFee) {
        this.userRegistFee = userRegistFee;
    }


    public String getDataPath() {
        return dataPath + File.separator + "mail";
    }

    public void setDataPath(String dataPath) {
        this.dataPath = dataPath;
    }

    public BigInteger getuploadMessageFee() {
        return uploadMessageFee;
    }

    public void setuploadMessageFee(BigInteger uploadMessageFee) {
        this.uploadMessageFee = uploadMessageFee;
    }
}
