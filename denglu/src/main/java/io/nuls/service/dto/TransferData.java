package io.nuls.service.dto;

import io.nuls.base.basic.NulsByteBuffer;
import io.nuls.base.basic.NulsOutputStreamBuffer;
import io.nuls.base.data.BaseNulsData;
import io.nuls.core.exception.NulsException;
import io.nuls.core.parse.SerializeUtils;

import java.io.IOException;

/**
 * @Author: zhoulijun
 * @Time: 2019-06-13 17:57
 * @Description: 功能描述
 */
public class TransferData extends BaseNulsData {
	
	private static final long serialVersionUID = 1L;

	private String fromAddress;

    private String toAddress;

    private String remark;

    @Override
    protected void serializeToStream(NulsOutputStreamBuffer stream) throws IOException {
        stream.writeString(fromAddress);
        stream.writeString(toAddress);
        stream.writeString(remark);
    }

    @Override
    public void parse(NulsByteBuffer byteBuffer) throws NulsException {
        this.fromAddress = byteBuffer.readString();
        this.toAddress = byteBuffer.readString();
        this.remark = byteBuffer.readString();
    }

    @Override
    public int size() {
        int s = 0;
        s += SerializeUtils.sizeOfString(fromAddress);
        s += SerializeUtils.sizeOfString(toAddress);
        s += SerializeUtils.sizeOfString(remark);
        return s;
    }

	public String getFromAddress() {
		return fromAddress;
	}

	public void setFromAddress(String fromAddress) {
		this.fromAddress = fromAddress;
	}

	public String getToAddress() {
		return toAddress;
	}

	public void setToAddress(String toAddress) {
		this.toAddress = toAddress;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

//    @Override
//    public String toString() {
//        return new StringBuilder("{")
//                .append("\"fromAddress\":")
//                .append(Arrays.toString(fromAddress))
//                .append(",\"toAddress\":")
//                .append(Arrays.toString(toAddress))
//                .append(",\"remark\":")
//                .append(Arrays.toString(remark))
//                .append('}').toString();
//    }

//    @Override
//    public boolean equals(Object o) {
//        if (this == o) return true;
//        if (!(o instanceof TransferData)) return false;
//
//        TransferData that = (TransferData) o;
//
//        if (!Arrays.equals(fromAddress, that.fromAddress)) return false;
//        if (!Arrays.equals(toAddress, that.toAddress)) return false;
//        if (!Arrays.equals(remark, that.remark)) return false;
//        return true;
//    }
//
//    @Override
//    public int hashCode() {
//        int result = Arrays.hashCode(fromAddress);
//        result = 31 * result + Arrays.hashCode(toAddress);
//        result = 31 * result + Arrays.hashCode(remark);
//        return result;
//    }

}
