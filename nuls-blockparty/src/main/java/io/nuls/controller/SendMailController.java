package io.nuls.controller;

import io.nuls.Config;
import io.nuls.base.api.provider.transaction;
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

import java.lang.System;
import io.nuls.base.api.provider.ServiceManager;
import io.nuls.base.api.provider.transaction.TransferService;

import javax.ws.rs.Path;
import javax.ws.rs.POST;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;


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

            long countLong = Long.parseLong(count);
            BigInteger itemCOUNT_BI = BigInteger.valueOf(countLong);
            String costPerItem = "0000000112221111";
            BigInteger costPerItemBI = BigInteger.valueOf(Long.parseLong(costPerItem));
            BigInteger firstTOTALbi = costPerItemBI.multiply(itemCOUNT_BI);  // subtract from sender, add to receiver

            AccountBalance beginSenderBalance = legderTools.getBalanceAndNonce(chainId, senderAddyStr, chainId, assetId);
            BigInteger sendBeginAvailBI =  beginSenderBalance.getAvailable();


            System.out.println("nms senderBal before signing:  " + sendBeginAvailBI);

            String[] tranferStrings = {senderAddyStr, recMailAddyStr, password};

            io.nuls.base.api.provider.Result apiResult= doTransferRequest(tranferStrings, firstTOTALbi, chainId, assetId);

            AccountBalance endSenderBal = legderTools.getBalanceAndNonce(chainId, senderAddyStr, chainId, assetId);
            BigInteger sendAfterAvailBI =  endSenderBal.getAvailable();
            io.nuls.controller.core.Result newResult = new Result();

            newResult.setMsg(apiResult.getMessage());

            String br = " ";
            String begBalStr1 = "Your beginning balance was: "  + sendBeginAvailBI;
            String andNowBalStr2 = br + "and now it is: " + sendAfterAvailBI;
            String yourTransferStr3 = br + "Your transfer of " + firstTOTALbi +  " to blockchain address: " + recMailAddyStr;
            String wasRecordedStr4 = br  + "was recorded in the blockchain and ledger. ";
            String pleaseReloadStr5 = br + "Please reload page to do another transfer.";

            String s1 = begBalStr1 + andNowBalStr2;
            String s2 = yourTransferStr3 + wasRecordedStr4 + pleaseReloadStr5;
            String successMsg = s1 + s2;

            newResult.setSuccess(apiResult.isSuccess());
            newResult.setMsg(successMsg);
            newResult.setData(apiResult.getData());
            return newResult;
        });
    }
    /**
     * //https://github.com/nuls-io/nuls-v2/blob/221c3c3007c78cc04b28f5068aa0c28e27cc3a6e/module/nuls-cmd-client/
     *      src/main/java/io/nuls/cmd/client/processor/transaction/TransferProcessor.java
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