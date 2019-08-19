package com.green.service;

import com.green.dao.MessagePojoDao;
import com.green.pojo.Message;
import com.green.pojo.MessagePojo;
import com.green.pojo.MessageUser;
import com.green.utils.Config;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class MessageService {

    public static final String FILE_NAME = "address";

    public static final String SPLIT = ";";

    @Autowired
    Config config;

    @Autowired
    MessagePojoDao messagePojoDao;

    public boolean hasAddressOrUsername(String address, String userName) throws IOException {
        return hasAddressOrUsername(getAllUsername(),address,userName);
    }
    public boolean hasAddressOrUsername(List<MessageUser> allMailAddress,String address,String userName) throws IOException {
        return allMailAddress.stream().anyMatch(mad->mad.getAddress().equals(address)||mad.getUserName().equals(userName));
    }

    private List<MessageUser> getAllUsername() throws IOException {
        List<MessageUser> res = new ArrayList<>();
        File file = new File(getDataFile());
        if (!file.exists()) {
            file.createNewFile();
        }
        BufferedReader reader = new BufferedReader(new FileReader(file));
        String line = reader.readLine();
        while (line != null) {
            String[] data = line.split(SPLIT);   // TODO:文件系统中 address/username/pubkey
            MessageUser mad = new MessageUser();
            mad.setAddress(data[0].getBytes());
            mad.setUserName(data[1]);
            mad.setPubKey(data[2].getBytes());
            res.add(mad);
            line = reader.readLine();
        }
        reader.close();
        return res;
    }
    private String getDataFile() {
        return config.getDataPath() + File.separator + FILE_NAME;
    }

    public Optional<MessageUser> getUserName(String address) throws IOException {
        return getAllUsername().stream().filter(d->d.getAddress().equals(address)).findFirst();
    }

    public Optional<MessageUser> getMessageAddressPubKey(String userName) throws IOException {
        return getAllUsername().stream().filter(d->d.getUserName().equals(userName)).findFirst();
    }


    public void savedb(Message req) {
        MessagePojo messagePojo = new MessagePojo();
        messagePojo.setAddress(req.getAddress());
        messagePojo.setContent(req.getContent());
        messagePojo.setCreateTime(req.getCreateTime());
        messagePojo.setCreateUser(req.getCreateUser());
        messagePojo.setPassword(req.getPassword());
        messagePojo.setPicturePath(req.getPicturePath());
        messagePojo.setId(UUID.randomUUID().toString());
        messagePojoDao.save(messagePojo);
    }

    public List<MessagePojo> getMessageList(byte[] address, boolean isAll) {
        if(isAll){
            return messagePojoDao.findAll();
        }
        else{
            return messagePojoDao.findAllByAddress(address.toString());
        }
    }
}
