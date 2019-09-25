package io.nuls.controller.vo;

/**
 * @Author: zhoulijun
 * @Time: 2019-06-13 18:14
 * @Description: 功能描述
 */
public class SendMailReq {

    private String mailAddress;

    private String title;   //nms  - the count

    private String content;

    private String password;

    private String senderAddress;

    public String getMailAddress() {
        return mailAddress;
    }

    public void setMailAddress(String mailAddress) {
        this.mailAddress = mailAddress;
    }

    public String getTitle() {
        return title;
    }   //nms - really the count

    public void setTitle(String title) {      //nms
        this.title = title;
    }  //nms

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSenderAddress() {
        return senderAddress;
    }

    public void setSenderAddress(String senderAddress) {
        this.senderAddress = senderAddress;
    }
}
