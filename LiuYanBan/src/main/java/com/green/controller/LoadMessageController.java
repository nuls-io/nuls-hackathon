package com.green.controller;

import com.green.controller.core.BaseController;
import com.green.controller.core.Result;
import com.green.pojo.Message;
import com.green.pojo.MessageUser;
import com.green.rpc.AccountTools;
import com.green.rpc.LegderTools;
import com.green.rpc.TransactionTools;
import com.green.rpc.vo.Account;
import com.green.rpc.vo.AccountBalance;
import com.green.service.MessageService;
import com.green.utils.Config;
import com.green.utils.Constant;
import io.nuls.base.RPCUtil;
import io.nuls.base.basic.AddressTool;
import io.nuls.base.basic.TransactionFeeCalculator;
import io.nuls.base.data.CoinData;
import io.nuls.base.data.CoinFrom;
import io.nuls.base.data.CoinTo;
import io.nuls.base.data.Transaction;
import io.nuls.base.signture.P2PHKSignature;
import io.nuls.core.constant.CommonCodeConstanst;
import io.nuls.core.exception.NulsException;
import io.nuls.core.exception.NulsRuntimeException;
import io.nuls.core.rpc.util.NulsDateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.Optional;


/**
 * @Author: zhoulijun
 * @Time: 2019-06-11 21:03
 * @Description: 功能描述
 */
@RestController
@CrossOrigin
@RequestMapping("/sendMessage")
public class LoadMessageController implements BaseController {

    @Autowired
    Config config;

    @Autowired
    AccountTools accountTools;

    @Autowired
    LegderTools legderTools;

    @Autowired
    TransactionTools transactionTools;

    @Autowired
    MessageService messageService;

    /**
     * 生成一个邮件收件地址
     * 需要扣除1个NULS作为手续费
     *
     * @param req
     * @return
     */
    @RequestMapping(value="/upload",method= RequestMethod.POST)
    public Result<String> sendMail(@RequestBody Message req){
        return call(()->{
            Objects.requireNonNull(req.getCreateUser(),"userName can't null");
            Objects.requireNonNull(req.getAddress(), "address can't null");
            Objects.requireNonNull(req.getPassword(),"address password can't null");
            Objects.requireNonNull(req.getContent(),"content can't null");
            int chainId = config.getChainId();
//            //验证账户有效性
//            if (!AddressTool.validAddress(chainId, req.getSenderAddress())) {
//                throw new NulsRuntimeException(CommonCodeConstanst.PARAMETER_ERROR);
//            }
            Optional<MessageUser> messageUser;
            try {
                messageUser = messageService.getMessageAddressPubKey(req.getCreateUser());
            }catch (Exception e){
                throw new NulsRuntimeException(CommonCodeConstanst.FAILED, "无效的发件人地址");
            }
            Account account = accountTools.getAccountByAddress(messageUser.get().getAddress().toString());
            Transaction tx = createLoadMessageTrasaction(account, req);
            //签名别名交易
            signTransaction(tx, account, req.getPassword());
            if (!transactionTools.newTx(tx)) {
                throw new NulsRuntimeException(CommonCodeConstanst.FAILED);
            }
            return new Result<>(tx.getHash().toHex());
        });
    }

    /**
     * 组装交易
     * @param account
     * @param req
     * @return
     */
    private Transaction createLoadMessageTrasaction(Account account,Message req) throws IOException, NulsException {
        Optional<MessageUser> messageUser;
        try {
            messageUser = messageService.getMessageAddressPubKey(req.getCreateUser());
        }catch (Exception e){
            throw new NulsRuntimeException(CommonCodeConstanst.PARAMETER_ERROR,"can't found username : " + req.getCreateUser() );
        }
        //获取邮箱地址对应的账户和公钥
        byte[] senderAddress = AddressTool.getAddress(account.getAddress());

        Transaction tx = new Transaction();
        tx.setType(Constant.TX_TYPE_SEND_MESSAGE);
        tx.setTime(NulsDateUtils.getCurrentTimeSeconds());
        tx.setTxData(buildTxData(account,messageUser.get(), senderAddress, req));
        tx.setCoinData(buildCoinData(tx,senderAddress));
        return tx;
    }

    private byte[] buildTxData(Account account, MessageUser messageUser, byte[] senderAddress, Message req) throws IOException {

        Message content = new Message();
        content.setContent(req.getContent());
        content.setCreateTime(new Date().toString());

        String path = config.getDataPath() + File.separator + req.getFile().getOriginalFilename() + (new Date().toString());
        content.setPicturePath(path);
        savePicture(req.getFile(), path);

        messageService.savedb(req);

        return content.serialize();
    }

    private byte[] buildCoinData(Transaction tx,byte[] senderAddress) throws IOException, NulsException {
        AccountBalance accountBalance = legderTools.getBalanceAndNonce(config.getChainId(), AddressTool.getStringAddressByBytes(senderAddress), config.getChainId(), config.getAssetId());
        byte locked = 0;
        byte[] nonce = RPCUtil.decode(accountBalance.getNonce());
        CoinFrom coinFrom = new CoinFrom(senderAddress, config.getChainId(), config.getAssetId(), config.getuploadMessageFee(), nonce, locked);
        CoinTo coinTo = new CoinTo(AddressTool.getAddress(Constant.BLACK_HOLE_ADDRESS), config.getChainId(), config.getAssetId(), config.getuploadMessageFee());
        int txSize = tx.size() + coinFrom.size() + coinTo.size() + P2PHKSignature.SERIALIZE_LENGTH;
        //计算手续费
        BigInteger fee = TransactionFeeCalculator.getNormalTxFee(txSize);
        //总费用为
        BigInteger totalAmount = config.getuploadMessageFee().add(fee);
        //验证发件人余额是否足够
        if(accountBalance.getAvailable().min(config.getuploadMessageFee().add(tx.getFee())).equals(accountBalance.getAvailable())){
            throw new NulsRuntimeException(CommonCodeConstanst.FAILED, "insufficient fee");
        }
        coinFrom.setAmount(totalAmount);
        CoinData coinData = new CoinData();
        coinData.setFrom(List.of(coinFrom));
        coinData.setTo(List.of(coinTo));
        return coinData.serialize();
    }


    public void savePicture(MultipartFile file, String path) throws IOException {
        //上传文件名
        String filename = file.getOriginalFilename();
        //服务器端保存的文件对象
        File serverFile = new File(path);

        // 转存文件
        InputStream in = file.getInputStream();
        BufferedReader br = new BufferedReader(new InputStreamReader(in));//添加缓冲
        BufferedWriter wr = new BufferedWriter(new FileWriter(serverFile));
        try{
            String line;
            while((line=br.readLine())!=null){
                wr.write(line);
                wr.newLine();
            }
            wr.flush();
//            System.out.println("文件完成转存。");
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            br.close();
            wr.close();
        }
    }




}
