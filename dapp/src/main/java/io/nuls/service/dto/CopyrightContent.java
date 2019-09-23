package io.nuls.service.dto;

import io.nuls.base.basic.NulsByteBuffer;
import io.nuls.base.basic.NulsOutputStreamBuffer;
import io.nuls.base.data.BaseNulsData;
import io.nuls.controller.vo.FileInfo;
import io.nuls.controller.vo.RightDescription;
import io.nuls.core.exception.NulsException;
import io.nuls.core.parse.SerializeUtils;

import java.io.IOException;
import java.util.Arrays;

/**
 * @Author: zhoulijun
 * @Time: 2019-06-13 17:57
 * @Description: 功能描述
 */
public class CopyrightContent extends BaseNulsData {

    private String address;

    private String password;

    private String hash;
    private String authorization;

    private String certificationName;
    private String powerinfoId;
    private String catalog;
    private String workName;
    private String fingerPrint;

    private String originalFileDigest;
    private String inventionType;

    private String productionTime;
    private String publishedTime;
    private String rightApplyTime;

    private String applicantId;
    private String applicantName;
    private String issuerId;
    private String issuer;

    private RightDescription rightDescription;

    private FileInfo fileInfo;

    @Override
    protected void serializeToStream(NulsOutputStreamBuffer stream) throws IOException {
        stream.writeString(address);

        stream.writeString(hash);
        stream.writeString(authorization);

        stream.writeString(certificationName);
        stream.writeString(powerinfoId);
        stream.writeString(catalog);

        stream.writeString(workName);
        stream.writeString(fingerPrint);

        stream.writeString(originalFileDigest);
        stream.writeString(inventionType);

        stream.writeString(productionTime);
        stream.writeString(publishedTime);
        stream.writeString(rightApplyTime);

        stream.writeString(applicantId);
        stream.writeString(applicantName);
        stream.writeString(issuerId);
        stream.writeString(issuer);

        stream.writeString(this.rightDescription.getOwnerId());
        stream.writeString(this.rightDescription.getOwnerName());
        stream.writeString(this.rightDescription.getRightDefinition());
        stream.writeString(this.rightDescription.getRightExpiration());
        stream.writeString(this.rightDescription.getRightSourceType());

        stream.writeString(this.fileInfo.getFileHash());
        stream.writeString(this.fileInfo.getFileType());
        stream.writeString(this.fileInfo.getSizes());
        stream.writeString(this.fileInfo.getStorageLocationURL());

    }

    @Override
    public void parse(NulsByteBuffer byteBuffer) throws NulsException {
        this.setAddress(byteBuffer.readString());

        this.setHash(byteBuffer.readString());
        this.setAuthorization(byteBuffer.readString());
        this.setCertificationName(byteBuffer.readString());
        this.setPowerinfoId(byteBuffer.readString());

        this.setCatalog(byteBuffer.readString());

        this.setWorkName(byteBuffer.readString());
        this.setFingerPrint(byteBuffer.readString());
        this.setOriginalFileDigest(byteBuffer.readString());
        this.setInventionType(byteBuffer.readString());

        this.setProductionTime(byteBuffer.readString());

        this.setPublishedTime(byteBuffer.readString());
        this.setRightApplyTime(byteBuffer.readString());

        this.setApplicantId(byteBuffer.readString());
        this.setApplicantName(byteBuffer.readString());
        this.setIssuerId(byteBuffer.readString());
        this.setIssuer(byteBuffer.readString());

        this.getRightDescription().setOwnerId(byteBuffer.readString());
        this.getRightDescription().setOwnerName(byteBuffer.readString());
        this.getRightDescription().setRightDefinition(byteBuffer.readString());
        this.getRightDescription().setRightExpiration(byteBuffer.readString());
        this.getRightDescription().setRightSourceType(byteBuffer.readString());

        this.getFileInfo().setFileHash(byteBuffer.readString());
        this.getFileInfo().setFileType(byteBuffer.readString());
        this.getFileInfo().setSizes(byteBuffer.readString());
        this.getFileInfo().setStorageLocationURL(byteBuffer.readString());
    }

    @Override
    public int size() {
        int s = 0;
        s += SerializeUtils.sizeOfString(address);

        s += SerializeUtils.sizeOfString(hash);
        s += SerializeUtils.sizeOfString(authorization);
        s += SerializeUtils.sizeOfString(certificationName);
        s += SerializeUtils.sizeOfString(powerinfoId);
        s += SerializeUtils.sizeOfString(catalog);
        s += SerializeUtils.sizeOfString(workName);
        s += SerializeUtils.sizeOfString(fingerPrint);
        s += SerializeUtils.sizeOfString(originalFileDigest);
        s += SerializeUtils.sizeOfString(inventionType);
        s += SerializeUtils.sizeOfString(productionTime);
        s += SerializeUtils.sizeOfString(publishedTime);
        s += SerializeUtils.sizeOfString(rightApplyTime);
        s += SerializeUtils.sizeOfString(applicantId);
        s += SerializeUtils.sizeOfString(applicantName);
        s += SerializeUtils.sizeOfString(issuerId);
        s += SerializeUtils.sizeOfString(issuer);

        s += SerializeUtils.sizeOfString(this.rightDescription.getOwnerId());
        s += SerializeUtils.sizeOfString(this.rightDescription.getOwnerName());
        s += SerializeUtils.sizeOfString(this.rightDescription.getRightDefinition());
        s += SerializeUtils.sizeOfString(this.rightDescription.getRightExpiration());
        s += SerializeUtils.sizeOfString(this.rightDescription.getRightSourceType());

        s += SerializeUtils.sizeOfString(this.fileInfo.getFileHash());
        s += SerializeUtils.sizeOfString(this.fileInfo.getFileType());
        s += SerializeUtils.sizeOfString(this.fileInfo.getSizes());
        s += SerializeUtils.sizeOfString(this.fileInfo.getStorageLocationURL());
        return s;
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

    public String getHash() {
        return hash;
    }

    public void setHash(String hash) {
        this.hash = hash;
    }

    public String getAuthorization() {
        return authorization;
    }

    public void setAuthorization(String authorization) {
        this.authorization = authorization;
    }

    public String getCertificationName() {
        return certificationName;
    }

    public void setCertificationName(String certificationName) {
        this.certificationName = certificationName;
    }

    public String getPowerinfoId() {
        return powerinfoId;
    }

    public void setPowerinfoId(String powerinfoId) {
        this.powerinfoId = powerinfoId;
    }

    public String getCatalog() {
        return catalog;
    }

    public void setCatalog(String catalog) {
        this.catalog = catalog;
    }

    public String getWorkName() {
        return workName;
    }

    public void setWorkName(String workName) {
        this.workName = workName;
    }

    public String getFingerPrint() {
        return fingerPrint;
    }

    public void setFingerPrint(String fingerPrint) {
        this.fingerPrint = fingerPrint;
    }

    public String getOriginalFileDigest() {
        return originalFileDigest;
    }

    public void setOriginalFileDigest(String originalFileDigest) {
        this.originalFileDigest = originalFileDigest;
    }

    public String getInventionType() {
        return inventionType;
    }

    public void setInventionType(String inventionType) {
        this.inventionType = inventionType;
    }

    public String getProductionTime() {
        return productionTime;
    }

    public void setProductionTime(String productionTime) {
        this.productionTime = productionTime;
    }

    public String getPublishedTime() {
        return publishedTime;
    }

    public void setPublishedTime(String publishedTime) {
        this.publishedTime = publishedTime;
    }

    public String getRightApplyTime() {
        return rightApplyTime;
    }

    public void setRightApplyTime(String rightApplyTime) {
        this.rightApplyTime = rightApplyTime;
    }

    public String getApplicantId() {
        return applicantId;
    }

    public void setApplicantId(String applicantId) {
        this.applicantId = applicantId;
    }

    public String getApplicantName() {
        return applicantName;
    }

    public void setApplicantName(String applicantName) {
        this.applicantName = applicantName;
    }

    public String getIssuerId() {
        return issuerId;
    }

    public void setIssuerId(String issuerId) {
        this.issuerId = issuerId;
    }

    public String getIssuer() {
        return issuer;
    }

    public void setIssuer(String issuer) {
        this.issuer = issuer;
    }

    public RightDescription getRightDescription() {
        return rightDescription;
    }

    public void setRightDescription(RightDescription rightDescription) {
        this.rightDescription = rightDescription;
    }

    public FileInfo getFileInfo() {
        return fileInfo;
    }

    public void setFileInfo(FileInfo fileInfo) {
        this.fileInfo = fileInfo;
    }

    @Override
    public String toString() {
        return "CopyrightContent{" +
                "address='" + address + '\'' +
                ", password='" + password + '\'' +
                ", hash='" + hash + '\'' +
                ", authorization='" + authorization + '\'' +
                ", certificationName='" + certificationName + '\'' +
                ", powerinfoId='" + powerinfoId + '\'' +
                ", catalog='" + catalog + '\'' +
                ", workName='" + workName + '\'' +
                ", fingerPrint='" + fingerPrint + '\'' +
                ", originalFileDigest='" + originalFileDigest + '\'' +
                ", inventionType='" + inventionType + '\'' +
                ", productionTime='" + productionTime + '\'' +
                ", publishedTime='" + publishedTime + '\'' +
                ", rightApplyTime='" + rightApplyTime + '\'' +
                ", applicantId='" + applicantId + '\'' +
                ", applicantName='" + applicantName + '\'' +
                ", issuerId='" + issuerId + '\'' +
                ", issuer='" + issuer + '\'' +
                ", rightDescription=" + rightDescription +
                ", fileInfo=" + fileInfo +
                '}';
    }
}
