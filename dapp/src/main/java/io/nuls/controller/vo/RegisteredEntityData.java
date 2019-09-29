package io.nuls.controller.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * @Author: zhoulijun
 * @Time: 2019-06-14 11:48
 * @Description: 功能描述
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class RegisteredEntityData {

    private String address;

    private String password;

    private String authorization;

    private String username;

    private String userType;

    private String registerationTime;

    private String ProxyPlatformID;

    private Person person;

    private Company company;

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
        return ProxyPlatformID;
    }

    public void setProxyPlatformID(String proxyPlatformID) {
        ProxyPlatformID = proxyPlatformID;
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
}
