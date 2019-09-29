package io.nuls.controller;


import io.nuls.Config;
import io.nuls.base.api.provider.transaction.facade.TransferReq;
//import io.nuls.base.api.provider.Result;

import io.nuls.controller.core.BaseController;
import io.nuls.controller.core.Result;
import io.nuls.controller.vo.MailAddressData;
import io.nuls.controller.vo.SendMailReq;
import io.nuls.core.core.annotation.Autowired;
import io.nuls.core.core.annotation.Component;
import io.nuls.rpc.AccountTools;
import io.nuls.rpc.LegderTools;
import io.nuls.rpc.TransactionTools;
import io.nuls.rpc.vo.AccountBalance;
import io.nuls.service.MailAddressService;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.math.BigInteger;
import java.util.Objects;
import java.util.Optional;


import java.lang.System;
import org.javatuples.*;
import io.nuls.base.api.provider.ServiceManager;
import io.nuls.base.api.provider.transaction.TransferService;


/**
 * @author nmschorr based on code from zhoulijun
 * @date  2019-09-24
 * @Description:
 */
@Path("/")
@Component
public class SendMailController implements BaseController {

    @Autowired
    Config config;

    @Autowired
    AccountTools accountTools;

    @Autowired
    LegderTools legderTools;

    @Autowired
    TransactionTools transactionTools;

    @Autowired
    MailAddressService mailAddressService;

    io.nuls.base.api.provider.Result doTransferRequest;

    /**
     * @param theREQUEST : request
     * @return Result
     */
    @Path("sendMail")
    @Produces(MediaType.APPLICATION_JSON)
    @POST
    //io.nuls.controller.core.Result
    public Result<String> sendMail(SendMailReq theREQUEST) {
        return call(() -> {
            Objects.requireNonNull(theREQUEST.getSenderAddress(), "sender address can't null");  //sender
            Objects.requireNonNull(theREQUEST.getMailAddress(), "mail address can't null");  // receiver
            Objects.requireNonNull(theREQUEST.getPassword(), "sender address password can't null");

            String senderAddyStr = theREQUEST.getSenderAddress();
            String recMailAddyStr = theREQUEST.getMailAddress();
            String password = theREQUEST.getPassword();
            String count = theREQUEST.getTitle();
            Integer chainId = config.getChainId();
            Integer assetId = config.getAssetId();
            byte[] receiverAddy_BYTES = senderAddyStr.getBytes();
            byte[] senderAddy_BYTES = recMailAddyStr.getBytes();
            Optional<MailAddressData> recAddy_OPT, senderAddy_OPT;
            senderAddy_OPT = mailAddressService.getMailAddress(senderAddyStr);
            recAddy_OPT = mailAddressService.getMailAddress(recMailAddyStr);

            long countLong = Long.parseLong(count);
            BigInteger itemCOUNT_BI = BigInteger.valueOf(countLong);
            String costPerItem = "0000000112221111";
            BigInteger costPerItemBI = BigInteger.valueOf(Long.parseLong(costPerItem));
            BigInteger firstTOTALbi = costPerItemBI.multiply(itemCOUNT_BI);  // subtract from sender, add to receiver

            // Ennead is python-like object from org.javatuples
            Ennead<String, String, String, Optional<MailAddressData>, Optional<MailAddressData>,
                    byte[], byte[], BigInteger, BigInteger> mainObject_JTUP;

            mainObject_JTUP = new Ennead<>(password, senderAddyStr, recMailAddyStr, senderAddy_OPT, recAddy_OPT,
                    senderAddy_BYTES, receiverAddy_BYTES, itemCOUNT_BI, firstTOTALbi);

            AccountBalance beginSenderBalance = legderTools.getBalanceAndNonce(chainId, senderAddyStr, chainId, assetId);
            System.out.println("nms senderBal before signing:  " + beginSenderBalance.getAvailable());

            String[] tranferStrings = {senderAddyStr, recMailAddyStr, password};

            io.nuls.base.api.provider.Result apiResult= doTransferRequest(tranferStrings, firstTOTALbi, chainId, assetId);

            AccountBalance endSenderBal = legderTools.getBalanceAndNonce(chainId, senderAddyStr, chainId, assetId);
            io.nuls.controller.core.Result newResult = new Result();
            newResult.setMsg(apiResult.getMessage());
            String s1 = "Your beginning balance was: "+beginSenderBalance + " and now it is: " + endSenderBal + "<br/>";
            String s2 = "Your transfer of " + costPerItemBI +  " to blockchain address: " + recMailAddyStr +
                    "<br/>" + " was recorded in the blockchain and ledger. Reload page to do another transfer.";
            String successMsg = s1 + s2;

            newResult.setSuccess(apiResult.isSuccess());
            newResult.setMsg(successMsg);
           // String theData = apiResult.getData().toString();
            newResult.setData(apiResult.getData());
            return newResult;






        });
    }
    /**
     * //https://github.com/nuls-io/nuls-v2/blob/221c3c3007c78cc04b28f5068aa0c28e27cc3a6e/module/nuls-cmd-client/src/main/java/io/nuls/cmd/client/processor/transaction/TransferProcessor.java
     * @return
     */
    private io.nuls.base.api.provider.Result doTransferRequest(String[] args,
                   BigInteger amount, Integer tempChainId, Integer tempAssetId) {
        String senderAddress = args[0];   //formAddress
        String toAddress = args[1];
        String password = args[2];

        TransferReq.TransferReqBuilder transReqBuilder;
        transReqBuilder = new TransferReq.TransferReqBuilder(tempChainId, tempAssetId);
        transReqBuilder.addForm(senderAddress, password, amount)
                .addTo(toAddress, amount);
        if (args.length == 5) {
            transReqBuilder.setRemark(args[4]);
        }
        TransferService transferService = ServiceManager.get(TransferService.class);
        io.nuls.base.api.provider.Result apiResult;
        TransferReq trr = new TransferReq();
        apiResult = transferService.transfer(transReqBuilder.build(trr));
        return apiResult;
    }

//    private Transaction createSendMailTransaction(SendMailReq request,
//                                                  Ennead<String, String, String,
//                                                          Optional<MailAddressData>, Optional<MailAddressData>,
//                                                          byte[], byte[], BigInteger, BigInteger> myGroup)
//            throws IOException, NulsException {
//
//        String senderAddy_STR = myGroup.getValue1();
//        String receiverAddy_STR = myGroup.getValue2();
//        Optional<MailAddressData> senderAddyData_OPT = myGroup.getValue3();
//        Optional<MailAddressData> recAddressData_OPT = myGroup.getValue4();
//        byte[] senderAddressBytes = myGroup.getValue5();
//        byte[] receiverAddressBytes = myGroup.getValue6();
//
//        if (senderAddyData_OPT.isEmpty()) {
//            throw new NulsRuntimeException(CommonCodeConstanst.PARAMETER_ERROR, "can't find sender address: " + senderAddy_STR);
//        }
//        if (recAddressData_OPT.isEmpty()) {
//            throw new NulsRuntimeException(CommonCodeConstanst.PARAMETER_ERROR, "can't find receiver address: " + receiverAddy_STR);
//        }
//        if (Arrays.equals(receiverAddressBytes, senderAddressBytes)) {
//            throw new NulsRuntimeException(CommonCodeConstanst.PARAMETER_ERROR, "sender equals receiver");
//        }
//        Account account = new Account();
//
//        Transaction tx = new Transaction();
//        String a = account.getEncryptedPrikeyHex();
//        String h = account.getPubkeyHex();
//
//        tx.setType(Constant.TX_TYPE_SEND_MAIL);
//        tx.setTime(NulsDateUtils.getCurrentTimeSeconds());
//
//        byte[] txData = buildTxData(myGroup);
//        byte[] cd = buildCoinData(tx, myGroup);
//
//        tx.setTxData(txData);
//        tx.setCoinData(cd);
//
//        System.out.println("nms transaction signature in Transaction(): " +
//                Arrays.toString(tx.getTransactionSignature()));
//
//        return tx;
//    }


//    private byte[] buildTxData(Ennead<String, String, String,
//            Optional<MailAddressData>, Optional<MailAddressData>,
//            byte[], byte[],
//            BigInteger, BigInteger> myGroup) throws IOException {
//
//        Optional<MailAddressData> senderAddyData_OPT = myGroup.getValue3();
//        Optional<MailAddressData> recAddressData_OPT = myGroup.getValue4();
//        byte[] senderAddress_BTS = myGroup.getValue5();
//        byte[] receiverAddress_BTS = myGroup.getValue6();
//        MailAddressData sendAdd_DATA = senderAddyData_OPT.get();
//        if (senderAddyData_OPT.isEmpty()) {
//            throw new NulsRuntimeException(CommonCodeConstanst.PARAMETER_ERROR, "can't find sender address: " + senderAddyData_OPT);
//        }
//        MailAddressData recAdd_DATA = recAddressData_OPT.get();
//        String senderPubKey_STR = sendAdd_DATA.getPubKey();
//        String recPubKey_STR = recAdd_DATA.getPubKey();
//
//        ECKey key = new ECKey();
//        byte[] pubkey = key.getPubKey();
//        byte[] privKey_BYTES = key.getPrivKeyBytes();
//
//        byte[] sender_ECK = ECIESUtil.encrypt(HexUtil.decode(senderPubKey_STR), privKey_BYTES);
//        byte[] receiver_ECK = ECIESUtil.encrypt(HexUtil.decode(recPubKey_STR), privKey_BYTES);
//        byte[] daysContent_BYTES = myGroup.getValue7().toString().getBytes(StandardCharsets.UTF_8);
//        byte[] countTitle_BYTES = myGroup.getValue8().toString().getBytes(StandardCharsets.UTF_8);
//
//        MailContent content = new MailContent();
//        content.setContent(ECIESUtil.encrypt(pubkey, daysContent_BYTES));
//        content.setTitle(ECIESUtil.encrypt(pubkey, countTitle_BYTES));
//        content.setReceiverAddress(receiverAddress_BTS);
//        content.setReceiverKey(receiver_ECK);
//        content.setSenderAddress(senderAddress_BTS);
//        content.setSenderKey(sender_ECK);
//        content.setTimestamp(System.currentTimeMillis());
//        return content.serialize();
//    }
//
//
//    private byte[] buildCoinData(Transaction tx,
//                                 Ennead<String, String, String, Optional<MailAddressData>, Optional<MailAddressData>,
//                                         byte[], byte[], BigInteger, BigInteger> myGroup)
//            throws IOException, NulsException {
//        int chId = config.getChainId();
//        int asId = config.getAssetId();
//        String sendAddyStr = myGroup.getValue1();
//        byte[] senderAddressBytes = myGroup.getValue5();
//        byte[] receiverAddressBytes = myGroup.getValue6();
//        BigInteger firstCost = myGroup.getValue8();
//        byte locked = 0;
//
//        AccountBalance sendAcctBal_OBJ = legderTools.getBalanceAndNonce(chId, sendAddyStr, chId, asId);
//        BigInteger avail_BI = sendAcctBal_OBJ.getAvailable();
//        byte[] nonce = RPCUtil.decode(sendAcctBal_OBJ.getNonce());
//        CoinFrom coinFrom = new CoinFrom();
//
//        coinFrom.setAddress(senderAddressBytes);
//        coinFrom.setAssetsChainId(chId);
//        coinFrom.setAssetsId(asId);
//        coinFrom.setAmount(firstCost);
//        coinFrom.setLocked(locked);
//        coinFrom.setNonce(nonce);
//
//        CoinTo coinTo = new CoinTo(receiverAddressBytes, chId, asId, firstCost);
//        coinTo.setAddress(receiverAddressBytes);
//
//        int txSize = tx.size() + coinFrom.size() + coinTo.size() + P2PHKSignature.SERIALIZE_LENGTH;
//        BigInteger sizeBasedTxFee_BI = TransactionFeeCalculator.getNormalTxFee(txSize);
//        BigInteger totalCostPlusFee_BI = firstCost.add(sizeBasedTxFee_BI);
//
//        if (avail_BI.min(totalCostPlusFee_BI).equals(avail_BI)) {
//            throw new NulsRuntimeException(CommonCodeConstanst.FAILED, "insufficient fee");
//        }
//        coinFrom.setAmount(totalCostPlusFee_BI);
//
//        CoinData coinData = new CoinData();
//        coinData.setFrom(List.of(coinFrom));
//        coinData.setTo(List.of(coinTo));
//
//        return coinData.serialize();
//    }
//
}