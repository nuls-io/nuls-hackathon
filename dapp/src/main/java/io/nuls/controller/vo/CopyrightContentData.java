package io.nuls.controller.vo;

import java.util.Date;

/**
 * @Author: zhoulijun
 * @Time: 2019-06-13 21:06
 * @Description: 功能描述
 */
public class CopyrightContentData {

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
    private String ApplicantName;
    private String IssuerId;
    private String Issuer;
    private RightDescription rightDescription;
    private FileInfo fileInfo;

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
        return ApplicantName;
    }

    public void setApplicantName(String applicantName) {
        ApplicantName = applicantName;
    }

    public String getIssuerId() {
        return IssuerId;
    }

    public void setIssuerId(String issuerId) {
        IssuerId = issuerId;
    }

    public String getIssuer() {
        return Issuer;
    }

    public void setIssuer(String issuer) {
        Issuer = issuer;
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
        return "CopyrightContentData{" +
                "hash='" + hash + '\'' +
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
                ", ApplicantName='" + ApplicantName + '\'' +
                ", IssuerId='" + IssuerId + '\'' +
                ", Issuer='" + Issuer + '\'' +
                ", rightDescription=" + rightDescription +
                ", fileInfo=" + fileInfo +
                '}';
    }
}
