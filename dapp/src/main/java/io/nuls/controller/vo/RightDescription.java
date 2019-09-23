package io.nuls.controller.vo;

public class RightDescription {

    private String ownerName;
    private String ownerId;
    private String rightExpiration;
    private String rightSourceType;
    private String rightDefinition;

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
    }

    public String getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(String ownerId) {
        this.ownerId = ownerId;
    }

    public String getRightExpiration() {
        return rightExpiration;
    }

    public void setRightExpiration(String rightExpiration) {
        this.rightExpiration = rightExpiration;
    }

    public String getRightSourceType() {
        return rightSourceType;
    }

    public void setRightSourceType(String rightSourceType) {
        this.rightSourceType = rightSourceType;
    }

    public String getRightDefinition() {
        return rightDefinition;
    }

    public void setRightDefinition(String rightDefinition) {
        this.rightDefinition = rightDefinition;
    }

    @Override
    public String toString() {
        return "RightDescription{" +
                "ownerName='" + ownerName + '\'' +
                ", ownerId='" + ownerId + '\'' +
                ", rightExpiration='" + rightExpiration + '\'' +
                ", rightSourceType='" + rightSourceType + '\'' +
                ", rightDefinition='" + rightDefinition + '\'' +
                '}';
    }
}
