package io.nuls.controller.vo;

import java.util.Date;

/**
 * @Author: zhoulijun
 * @Time: 2019-06-13 21:06
 * @Description: 功能描述
 */
public class MailContentData {

    private String hash;

    private String senderMailAddress;

    private String receiverMailAddress;

    private long title;   //nms

    private String content;

    private String sender;

    private Date date;

    public long getTitle() {
        return title;
    }  //nms

    public void setTitle(long title) {
        this.title = title;
    }  //nms

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getSenderMailAddress() {
        return senderMailAddress;
    }

    public void setSenderMailAddress(String senderMailAddress) {
        this.senderMailAddress = senderMailAddress;
    }

    public String getReceiverMailAddress() {
        return receiverMailAddress;
    }

    public void setReceiverMailAddress(String receiverMailAddress) {
        this.receiverMailAddress = receiverMailAddress;
    }

    public String getHash() {
        return hash;
    }

    public void setHash(String hash) {
        this.hash = hash;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
