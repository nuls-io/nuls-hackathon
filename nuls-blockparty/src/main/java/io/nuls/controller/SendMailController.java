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
import java.math.BigInteger;
import java.util.Objects;
import java.util.Optional;

import java.lang.System;
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
//            Ennead<String, String, String, Optional<MailAddressData>, Optional<MailAddressData>,
//                    byte[], byte[], BigInteger, BigInteger> mainObject_JTUP;
//
//            mainObject_JTUP = new Ennead<>(password, senderAddyStr, recMailAddyStr, senderAddy_OPT, recAddy_OPT,
//                    senderAddy_BYTES, receiverAddy_BYTES, itemCOUNT_BI, firstTOTALbi);

            AccountBalance beginSenderBalance = legderTools.getBalanceAndNonce(chainId, senderAddyStr, chainId, assetId);
            System.out.println("nms senderBal before signing:  " + beginSenderBalance.getAvailable());

            String[] tranferStrings = {senderAddyStr, recMailAddyStr, password};

            io.nuls.base.api.provider.Result apiResult= doTransferRequest(tranferStrings, firstTOTALbi, chainId, assetId);

            AccountBalance endSenderBal = legderTools.getBalanceAndNonce(chainId, senderAddyStr, chainId, assetId);
            io.nuls.controller.core.Result newResult = new Result();
            newResult.setMsg(apiResult.getMessage());

            br =  "<br/>";
            begBalStr = "Your beginning balance was: "  "+beginSenderBalance + ";
            andNowBalStr = " and now it is: " + endSenderBal + br;


            String s1 = begBalStr + " and now it is: " + endSenderBal + "<br/>";
            String s2 = "Your transfer of " + costPerItemBI +  " to blockchain address: " + recMailAddyStr +
                    "<br/>" + " was recorded in the blockchain and ledger. Reload page to do another transfer.";
            String successMsg = s1 + s2;

            newResult.setSuccess(apiResult.isSuccess());
            newResult.setMsg(successMsg);
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

}