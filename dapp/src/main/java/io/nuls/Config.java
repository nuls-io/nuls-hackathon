package io.nuls;

import io.nuls.core.core.annotation.Configuration;

import java.io.File;
import java.math.BigInteger;

/**
 * @Author: yves
 * @Time: 2019-08-13 14:41
 * @Description: 功能描述
 */
@Configuration(domain = "copyright")
public class Config {

    /**
     * 当前运行的chain id 来自配置文件
     */
    private int chainId;

    /**
     * 默认资产id
     */
    private int assetId;

    private BigInteger standardFee;

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

    public String getDataPath() {
        return dataPath + File.separator + "copyright";
    }

    public void setDataPath(String dataPath) {
        this.dataPath = dataPath;
    }

    public BigInteger getStandardFee() {
        return standardFee;
    }

    public void setStandardFee(BigInteger standardFee) {
        this.standardFee = standardFee;
    }
}
