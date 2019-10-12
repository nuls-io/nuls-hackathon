package io.nuls.rpctools.vo;

/**
 * 交易注册类
 * Transaction registration class
 *
 * @author tag
 * 2018/11/30
 */
public class TxRegisterDetail {
    /**
     * 交易类型
     * Transaction type
     */
    private int txType;
    /**
     * 是否是系统交易
     * Is it a system transaction
     */
    private boolean systemTx;
    /**
     * 是否是解锁交易
     * Is it a system transaction
     */
    private boolean unlockTx;
    /**
     * 交易是否需要签名
     * Is it a system transaction
     */
    private boolean verifySignature;

    private boolean verifyFee;

    public int getTxType() {
        return txType;
    }

    public void setTxType(int txType) {
        this.txType = txType;
    }

    public boolean getSystemTx() {
        return systemTx;
    }

    public void setSystemTx(boolean systemTx) {
        this.systemTx = systemTx;
    }

    public boolean getUnlockTx() {
        return unlockTx;
    }

    public void setUnlockTx(boolean unlockTx) {
        this.unlockTx = unlockTx;
    }

    public boolean getVerifySignature() {
        return verifySignature;
    }

    public void setVerifySignature(boolean verifySignature) {
        this.verifySignature = verifySignature;
    }

    public boolean getVerifyFee() {
        return verifyFee;
    }

    public void setVerifyFee(boolean verifyFee) {
        this.verifyFee = verifyFee;
    }

    @Override
    public String toString() {
        return "TxRegisterDetail{" +
                "txType=" + txType +
                ", systemTx=" + systemTx +
                ", unlockTx=" + unlockTx +
                ", verifySignature=" + verifySignature +
                ", verifyFee=" + verifyFee +
                '}';
    }
}
