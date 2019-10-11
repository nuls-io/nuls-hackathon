package com.green.pojo;

import io.nuls.base.basic.NulsByteBuffer;
import io.nuls.base.basic.NulsOutputStreamBuffer;
import io.nuls.base.data.BaseNulsData;
import io.nuls.core.exception.NulsException;
import io.nuls.core.parse.SerializeUtils;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.Entity;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

@Entity
@Component
public class Message extends BaseNulsData {


    String createUser;
    String address;
    String password;

    String createTime;
    String content;
    String picturePath;
    MultipartFile file;


    public String getCreateUser() {
        return createUser;
    }

    public void setCreateUser(String createUser) {
        this.createUser = createUser;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getPicturePath() {
        return picturePath;
    }

    public void setPicturePath(String picturePath) {
        this.picturePath = picturePath;
    }

    public MultipartFile getFile() {
        return file;
    }

    public void setFile(MultipartFile file) {
        this.file = file;
    }

    @Override
    protected void serializeToStream(NulsOutputStreamBuffer stream) throws IOException {
        /**
         *     String createUser;
         *     String address;
         *     String password;
         *
         *     String createTime;
         *     String content;
         *     String picturePath;
         *     MultipartFile file;
         */
        stream.writeBytesWithLength(createUser.getBytes());
        stream.writeBytesWithLength(address.getBytes());
        stream.writeBytesWithLength(createTime.getBytes());
        stream.writeBytesWithLength(content.getBytes());
        stream.writeBytesWithLength(picturePath.getBytes());
        stream.writeBytesWithLength(file.toString().getBytes());
    }

    @Override
    public void parse(NulsByteBuffer byteBuffer) throws NulsException {
        this.createUser = byteBuffer.readByLengthByte().toString();
        this.address = byteBuffer.readByLengthByte().toString();
        this.createTime = byteBuffer.readByLengthByte().toString();
        this.content = byteBuffer.readByLengthByte().toString();
        this.picturePath = byteBuffer.readByLengthByte().toString();
        byte[] loc_file = byteBuffer.readByLengthByte();

        InputStream inputStream = new ByteArrayInputStream(loc_file);
        try {
            String[] arr = this.picturePath.split("/");
            String fileName = arr[arr.length-1];
            MultipartFile file1 = new MockMultipartFile(fileName, inputStream);
            this.file = file1;
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public int size() {
        int s = 0;
        s += SerializeUtils.sizeOfBytes(createUser.getBytes());
        s += SerializeUtils.sizeOfBytes(address.getBytes());
        s += SerializeUtils.sizeOfBytes(createTime.getBytes());
        s += SerializeUtils.sizeOfBytes(content.getBytes());
        s += SerializeUtils.sizeOfBytes(picturePath.getBytes());
        s += SerializeUtils.sizeOfBytes(content.getBytes());
        try {
            s += SerializeUtils.sizeOfBytes(file.getBytes());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return s;
    }
}
