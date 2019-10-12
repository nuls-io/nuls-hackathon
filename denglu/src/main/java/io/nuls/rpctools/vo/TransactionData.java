package io.nuls.rpctools.vo;

import java.math.BigInteger;

public class TransactionData {
	
	public String address;
	public int assetsChainId;
	public int assetsId;
	public BigInteger amount;
	public String password;
	public Long lockTime;
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getAssetsChainId() {
		return assetsChainId;
	}
	public void setAssetsChainId(int assetsChainId) {
		this.assetsChainId = assetsChainId;
	}
	public int getAssetsId() {
		return assetsId;
	}
	public void setAssetsId(int assetsId) {
		this.assetsId = assetsId;
	}
	public BigInteger getAmount() {
		return amount;
	}
	public void setAmount(BigInteger amount) {
		this.amount = amount;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Long getLockTime() {
		return lockTime;
	}
	public void setLockTime(Long lockTime) {
		this.lockTime = lockTime;
	}

}
