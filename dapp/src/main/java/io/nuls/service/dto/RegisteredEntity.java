package io.nuls.service.dto;

import io.nuls.base.basic.NulsByteBuffer;
import io.nuls.base.basic.NulsOutputStreamBuffer;
import io.nuls.base.data.BaseNulsData;
import io.nuls.controller.vo.Company;
import io.nuls.controller.vo.Person;
import io.nuls.core.exception.NulsException;
import io.nuls.core.parse.SerializeUtils;

import java.io.IOException;

/**
 * @Author: zhoulijun
 * @Time: 2019-06-12 17:08
 * @Description: 功能描述
 */
public class RegisteredEntity extends BaseNulsData {

    private byte[] address;

    private byte[] password;

    private String authorization;

    private String username;

    private String userType;

    private String registerationTime;

    private String proxyPlatformID;

    private Person person;

    private Company company;

    public byte[] getAddress() {
        return address;
    }

    public void setAddress(byte[] address) {
        this.address = address;
    }

    public byte[] getPassword() {
        return password;
    }

    public void setPassword(byte[] password) {
        this.password = password;
    }

    public String getAuthorization() {
        return authorization;
    }

    public void setAuthorization(String authorization) {
        this.authorization = authorization;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getRegisterationTime() {
        return registerationTime;
    }

    public void setRegisterationTime(String registerationTime) {
        this.registerationTime = registerationTime;
    }

    public String getProxyPlatformID() {
        return proxyPlatformID;
    }

    public void setProxyPlatformID(String proxyPlatformID) {
        this.proxyPlatformID = proxyPlatformID;
    }

    public Person getPerson() {
        return person;
    }

    public void setPerson(Person person) {
        this.person = person;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    @Override
    protected void serializeToStream(NulsOutputStreamBuffer stream) throws IOException {
        stream.writeBytesWithLength(address);

        stream.writeString(authorization);
        stream.writeString(username);
        stream.writeString(userType);
        stream.writeString(registerationTime);
        stream.writeString(proxyPlatformID);

        stream.writeString(person.getName());
        stream.writeString(person.getGender());
        stream.writeString(person.getId());
        stream.writeString(person.getPhoneNum());
        stream.writeString(person.getAddress());
        stream.writeString(person.getNation());

        stream.writeString(company.getName());
        stream.writeString(company.getCreditCode());
        stream.writeString(company.getContactPerson());
        stream.writeString(company.getContactPhone());




    }

    @Override
    public void parse(NulsByteBuffer byteBuffer) throws NulsException {

        this.setAddress(byteBuffer.readByLengthByte());

        this.setAuthorization(byteBuffer.readString());
        this.setUsername(byteBuffer.readString());
        this.setUserType(byteBuffer.readString());
        this.setRegisterationTime(byteBuffer.readString());
        this.setProxyPlatformID(byteBuffer.readString());

        this.getPerson().setName(byteBuffer.readString());
        this.getPerson().setGender(byteBuffer.readString());
        this.getPerson().setId(byteBuffer.readString());
        this.getPerson().setPhoneNum(byteBuffer.readString());
        this.getPerson().setAddress(byteBuffer.readString());
        this.getPerson().setNation(byteBuffer.readString());

        this.getCompany().setName(byteBuffer.readString());
        this.getCompany().setCreditCode(byteBuffer.readString());
        this.getCompany().setContactPerson(byteBuffer.readString());
        this.getCompany().setContactPhone(byteBuffer.readString());
    }


    @Override
    public int size() {
        int s = 0;
        s += SerializeUtils.sizeOfBytes(address);

        s += SerializeUtils.sizeOfString(authorization);
        s += SerializeUtils.sizeOfString(username);
        s += SerializeUtils.sizeOfString(userType);
        s += SerializeUtils.sizeOfString(registerationTime);
        s += SerializeUtils.sizeOfString(proxyPlatformID);

        s += SerializeUtils.sizeOfString(person.getName());
        s += SerializeUtils.sizeOfString(person.getGender());
        s += SerializeUtils.sizeOfString(person.getId());
        s += SerializeUtils.sizeOfString(person.getPhoneNum());
        s += SerializeUtils.sizeOfString(person.getAddress());
        s += SerializeUtils.sizeOfString(person.getNation());

        s += SerializeUtils.sizeOfString(company.getName());
        s += SerializeUtils.sizeOfString(company.getCreditCode());
        s += SerializeUtils.sizeOfString(company.getContactPerson());
        s += SerializeUtils.sizeOfString(company.getContactPhone());
        return s;
    }

    @Override
    public String toString() {
        return "RegisteredEntity{" +
                "address=" + address +
                ", password=" + password +
                ", authorization='" + authorization + '\'' +
                ", username='" + username + '\'' +
                ", userType='" + userType + '\'' +
                ", registerationTime='" + registerationTime + '\'' +
                ", proxyPlatformID='" + proxyPlatformID + '\'' +
                ", person=" + person +
                ", company=" + company +
                '}';
    }
}
