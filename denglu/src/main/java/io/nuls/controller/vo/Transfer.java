package io.nuls.controller.vo;

import java.math.BigInteger;

public class Transfer {

	public String fromAddress;
//	public int fromAssetsChainId;
//	public int fromAssetsId;
	public String fromPassword;
	public BigInteger amount;
	public String toAddress;
//	public int toAssetsChainId;
//	public int toAssetsId;
	public String remark;
	
	public String getFromAddress() {
		return fromAddress;
	}
	public void setFromAddress(String fromAddress) {
		this.fromAddress = fromAddress;
	}
//	public int getFromAssetsChainId() {
//		return fromAssetsChainId;
//	}
//	public void setFromAssetsChainId(int fromAssetsChainId) {
//		this.fromAssetsChainId = fromAssetsChainId;
//	}
//	public int getFromAssetsId() {
//		return fromAssetsId;
//	}
//	public void setFromAssetsId(int fromAssetsId) {
//		this.fromAssetsId = fromAssetsId;
//	}
	public String getFromPassword() {
		return fromPassword;
	}
	public void setFromPassword(String fromPassword) {
		this.fromPassword = fromPassword;
	}
	public BigInteger getAmount() {
		return amount;
	}
	public void setAmount(BigInteger amount) {
		this.amount = amount;
	}
	public String getToAddress() {
		return toAddress;
	}
	public void setToAddress(String toAddress) {
		this.toAddress = toAddress;
	}
//	public int getToAssetsChainId() {
//		return toAssetsChainId;
//	}
//	public void setToAssetsChainId(int toAssetsChainId) {
//		this.toAssetsChainId = toAssetsChainId;
//	}
//	public int getToAssetsId() {
//		return toAssetsId;
//	}
//	public void setToAssetsId(int toAssetsId) {
//		this.toAssetsId = toAssetsId;
//	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}

}
