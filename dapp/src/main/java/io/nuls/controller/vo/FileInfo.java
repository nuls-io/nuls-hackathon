package io.nuls.controller.vo;

public class FileInfo {

    private String fileType;
    private String sizes;
    private String fileHash;
    private String storageLocationURL;

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public String getSizes() {
        return sizes;
    }

    public void setSizes(String sizes) {
        this.sizes = sizes;
    }

    public String getFileHash() {
        return fileHash;
    }

    public void setFileHash(String fileHash) {
        this.fileHash = fileHash;
    }

    public String getStorageLocationURL() {
        return storageLocationURL;
    }

    public void setStorageLocationURL(String storageLocationURL) {
        this.storageLocationURL = storageLocationURL;
    }

    @Override
    public String toString() {
        return "FileInfo{" +
                "fileType='" + fileType + '\'' +
                ", sizes='" + sizes + '\'' +
                ", fileHash='" + fileHash + '\'' +
                ", storageLocationURL='" + storageLocationURL + '\'' +
                '}';
    }
}
