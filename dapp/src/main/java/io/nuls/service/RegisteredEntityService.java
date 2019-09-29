package io.nuls.service;

import ch.qos.logback.classic.Logger;
import io.nuls.Config;
import io.nuls.controller.vo.Company;
import io.nuls.controller.vo.Person;
import io.nuls.controller.vo.RegisteredEntityData;
import io.nuls.core.core.annotation.Autowired;
import io.nuls.core.core.annotation.Service;
import io.nuls.core.log.Log;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * @Author: zhoulijun
 * @Time: 2019-06-12 11:53
 * @Description: 登记实体
 */
@Service
public class RegisteredEntityService {

    public static final String FILE_NAME = "register";

    public static final String SPLIT = ";";

    @Autowired
    Config config;

    public void saveRegisteredEntity(RegisteredEntityData registeredEntityData) {
        synchronized (this){
            try {
                List<RegisteredEntityData> data = getAllRegisteredEntity();
                if(hasUsername(data, registeredEntityData.getUsername())){
                    Log.error("entity username exists");
                    return ;
                }
                data.add(registeredEntityData);
                saveRegisteredEntityToFile(data);
            } catch (IOException e) {
                Log.error("save register file fail",e);
            }

        }
    }

    public Optional<RegisteredEntityData> getRegisteredEntityPubKey(String username) throws IOException {
        return getAllRegisteredEntity().stream().filter(d->d.getUsername().equals(username)).findFirst();
    }

    public Optional<RegisteredEntityData> getRegisteredEntity(String username) throws IOException {
        return getAllRegisteredEntity().stream().filter(d->d.getUsername().equals(username)).findFirst();
    }

    public void removeRegisteredEntity(String username) {
        synchronized (this){
            try {
                List<RegisteredEntityData> data = getAllRegisteredEntity().stream().filter(d->!d.getUsername().equals(username)).collect(Collectors.toList());
                saveRegisteredEntityToFile(data);
            } catch (IOException e) {
                Log.error("save register file fail",e);
            }

        }
    }

    public boolean hasUsername(String username) throws IOException {
        return hasUsername(getAllRegisteredEntity(), username);
    }

    public boolean hasUsername(List<RegisteredEntityData> allRegisteredEntity, String username) throws IOException {
        return allRegisteredEntity.stream().anyMatch(mad-> mad.getUsername().equals(username));
    }

    private List<RegisteredEntityData> getAllRegisteredEntity() throws IOException {
        List<RegisteredEntityData> res = new ArrayList<>();
        File file = new File(getDataFile());
        if (!file.exists()) {
            file.createNewFile();
        }
        BufferedReader reader = new BufferedReader(new FileReader(file));
        String line = reader.readLine();

        while (line != null) {
            String[] data = line.split(SPLIT);
            RegisteredEntityData mad = new RegisteredEntityData();
            mad.setPerson(new Person());
            mad.setCompany(new Company());

            mad.setAddress(data[0]);
            mad.setAuthorization(data[1]);
            mad.setUsername(data[2]);
            mad.setUserType(data[3]);
            mad.setRegisterationTime(data[4]);
            mad.setProxyPlatformID(data[5]);

            mad.getPerson().setName(data[6]);
            mad.getPerson().setGender(data[7]);
            mad.getPerson().setId(data[8]);
            mad.getPerson().setPhoneNum(data[9]);
            mad.getPerson().setAddress(data[10]);
            mad.getPerson().setNation(data[11]);

            mad.getCompany().setName(data[12]);
            mad.getCompany().setCreditCode(data[13]);
            mad.getCompany().setContactPerson(data[14]);
            mad.getCompany().setContactPhone(data[15]);
            Log.debug("*******RegisteredEntityData*******" + mad.toString());
            res.add(mad);
            line = reader.readLine();
        }
        reader.close();
        return res;
    }

    private void saveRegisteredEntityToFile(List<RegisteredEntityData> data) throws IOException {
        System.out.println("保存文件: " + data.size()+" | content: " +data.toString());
        File file = new File(getDataFile());
        if (file.exists()) {
            file.delete();
        }
        file.createNewFile();
        BufferedWriter writer = new BufferedWriter(new FileWriter(file));
        for (RegisteredEntityData d : data) {
            String item = new StringBuilder()
                    .append(d.getAddress()).append(SPLIT)
                    .append(d.getAuthorization()).append(SPLIT)
                    .append(d.getUsername()).append(SPLIT)
                    .append(d.getUserType()).append(SPLIT)
                    .append(d.getRegisterationTime()).append(SPLIT)
                    .append(d.getProxyPlatformID()).append(SPLIT)

                    .append(d.getPerson().getName()).append(SPLIT)
                    .append(d.getPerson().getGender()).append(SPLIT)
                    .append(d.getPerson().getId()).append(SPLIT)
                    .append(d.getPerson().getPhoneNum()).append(SPLIT)
                    .append(d.getPerson().getAddress()).append(SPLIT)
                    .append(d.getPerson().getNation()).append(SPLIT)

                    .append(d.getCompany().getName()).append(SPLIT)
                    .append(d.getCompany().getCreditCode()).append(SPLIT)
                    .append(d.getCompany().getContactPerson()).append(SPLIT)
                    .append(d.getCompany().getContactPhone()).append(SPLIT)
                    .toString();
            writer.write(item);
            writer.newLine();
        }
        writer.flush();
        writer.close();
    }

    private String getDataFile() {
        return config.getDataPath() + File.separator + FILE_NAME;
    }

}
