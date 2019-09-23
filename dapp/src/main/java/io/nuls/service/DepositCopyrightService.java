package io.nuls.service;

import io.nuls.Config;
import io.nuls.base.basic.AddressTool;
import io.nuls.base.basic.NulsByteBuffer;
import io.nuls.controller.vo.CopyrightContentData;
import io.nuls.controller.vo.FileInfo;
import io.nuls.controller.vo.RightDescription;
import io.nuls.core.basic.InitializingBean;
import io.nuls.core.constant.CommonCodeConstanst;
import io.nuls.core.core.annotation.Autowired;
import io.nuls.core.core.annotation.Service;
import io.nuls.core.crypto.ECIESUtil;
import io.nuls.core.crypto.ECKey;
import io.nuls.core.crypto.HexUtil;
import io.nuls.core.exception.CryptoException;
import io.nuls.core.exception.NulsException;
import io.nuls.core.exception.NulsRuntimeException;
import io.nuls.service.dto.CopyrightContent;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Author: zhoulijun
 * @Time: 2019-06-12 11:55
 * @Description: 功能描述
 */
@Service
public class DepositCopyrightService implements InitializingBean {

    public static final String SPLIT = ";";

    @Autowired
    Config config;

    /**
     * 保存一封邮件
     * @return
     */
    public void saveCopyright(String hash, CopyrightContent copyrightContent) throws IOException {
        //存储邮件内容到文件
        saveCopyrightContent(hash, copyrightContent);
    }

    private void saveCopyrightContent(String hash, CopyrightContent copyrightContent) throws IOException {
        File file = new File(getCopyrightData() + File.separator + hash);
        if(file.exists()){
            throw new NulsRuntimeException(CommonCodeConstanst.DATA_ERROR,"save copyright fail , copyright content file exists");
        }
        BufferedWriter outputStream = new BufferedWriter(new FileWriter(file));
        outputStream.write(HexUtil.encode(copyrightContent.serialize()));
        outputStream.flush();
        outputStream.close();
    }

    /**
     * 获取版权内容
     */
    public CopyrightContent getCoyprightContent(String hash) throws IOException, NulsException, CryptoException {

        // 版本文件保存目录
        File file = new File(getCopyrightData() + File.separator + hash);
        if(!file.exists()){
            throw new NulsRuntimeException(CommonCodeConstanst.DATA_ERROR, "error copyright hash");
        }

        BufferedReader inputStream = new BufferedReader(new FileReader(file));
        String tmp = inputStream.readLine();

        CopyrightContent copyrightContent = new CopyrightContent();
        copyrightContent.setFileInfo(new FileInfo());
        copyrightContent.setRightDescription(new RightDescription());
        copyrightContent.parse(new NulsByteBuffer(HexUtil.decode(tmp)));
        inputStream.close();

        return copyrightContent;
    }

    public List<CopyrightContent> getCopyrightList(String address, ECKey ecKey) throws IOException, CryptoException, NulsException {
        File file = new File((getCopyrightData()) + File.separator + address);
        if(!file.exists()){
            return List.of();
        }
        List<CopyrightContent> list = new ArrayList<>();
        try(BufferedReader reader = new BufferedReader(new FileReader(file))){
            String hash = reader.readLine();
            while(hash != null){
                CopyrightContent copyricghtContent = getCoyprightContent(hash);
                copyricghtContent.setHash(hash);
                list.add(copyricghtContent);
                hash = reader.readLine();
            }
        }
        return list;
    }

    @Override
    public void afterPropertiesSet() throws NulsException {
        //初始化数据存储文件夹
        File file = new File(config.getDataPath());
        if(!file.exists()){
            file.mkdir();
        }
        createDir(getCopyrightData());
    }

    public String getCopyrightData(){
        return config.getDataPath() + File.separator + "copyright-data";
    }

    private File createDir(String fileName){
        File file = new File(fileName);
        if(!file.exists()){
            file.mkdir();
        }
        return file;
    }

}
