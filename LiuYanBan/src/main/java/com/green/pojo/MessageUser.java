package com.green.pojo;

import io.nuls.base.basic.NulsByteBuffer;
import io.nuls.base.basic.NulsOutputStreamBuffer;
import io.nuls.base.data.BaseNulsData;
import io.nuls.core.exception.NulsException;
import io.nuls.core.parse.SerializeUtils;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class MessageUser extends BaseNulsData {
    public String userName;

    private byte[] address;

    private byte[] pubKey;

    public String password;



    public byte[] getAddress() {
        return address;
    }

    public void setAddress(byte[] address) {
        this.address = address;
    }

    public byte[] getPubKey() {
        return pubKey;
    }

    public void setPubKey(byte[] pubKey) {
        this.pubKey = pubKey;
    }


    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }



    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    protected void serializeToStream(NulsOutputStreamBuffer stream) throws IOException {
        stream.writeBytesWithLength(address);
        stream.writeString(userName);
        stream.writeBytesWithLength(pubKey);
    }

    @Override
    public void parse(NulsByteBuffer byteBuffer) throws NulsException {
        address = byteBuffer.readByLengthByte();
        userName = byteBuffer.readString();
        pubKey = byteBuffer.readByLengthByte();
    }

    @Override
    public int size() {
        int s = 0;
        s += SerializeUtils.sizeOfBytes(address);
        s += SerializeUtils.sizeOfString(userName);
        s += SerializeUtils.sizeOfBytes(pubKey);
        return s;
    }
}
