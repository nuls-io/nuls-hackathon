package io.nuls.controller;

import io.nuls.base.api.provider.Provider;
import io.nuls.txhander.SendMailProcessor;
import io.nuls.core.constant.BaseConstant;
import io.nuls.core.model.StringUtils;
import io.nuls.core.rpc.model.CmdAnnotation;
import io.nuls.core.rpc.model.Parameter;
import io.nuls.core.rpc.model.message.Response;
import io.nuls.service.MailAddressService;

import io.nuls.core.crypto.ECKey;
import io.nuls.core.exception.NulsException;
import io.nuls.core.exception.NulsRuntimeException;
import io.nuls.core.rpc.util.NulsDateUtils;
import io.nuls.rpc.AccountTools;
import io.nuls.rpc.LegderTools;
import io.nuls.rpc.TransactionTools;
import io.nuls.rpc.vo.Account;
import io.nuls.base.api.provider.account.*;
import io.nuls.rpc.vo.AccountBalance;
import io.nuls.base.data.BlockHeader;
import io.nuls.Config;
import io.nuls.Constant;
import io.nuls.base.RPCUtil;
import io.nuls.base.basic.TransactionFeeCalculator;
import io.nuls.base.data.Block;
import io.nuls.base.data.BaseNulsData;
import io.nuls.base.data.po.BlockHeaderPo;
import io.nuls.base.data.CoinData;
import io.nuls.base.data.CoinFrom;
import io.nuls.base.data.CoinTo;
import io.nuls.base.data.Transaction;
import io.nuls.base.signture.P2PHKSignature;
import io.nuls.controller.core.BaseController;
import io.nuls.controller.core.Result;
import io.nuls.controller.vo.MailAddressData;
import io.nuls.service.dto.MailContent;
import io.nuls.controller.vo.SendMailReq;
import io.nuls.core.constant.CommonCodeConstanst;
import io.nuls.core.core.annotation.Autowired;
import io.nuls.core.core.annotation.Component;
import io.nuls.core.crypto.ECIESUtil;
import io.nuls.core.crypto.HexUtil;
import io.nuls.core.rpc.model.Parameter;
import io.nuls.base.api.provider.block.facade.GetBlockHeaderByHeightReq;
import io.nuls.base.api.provider.block.facade.GetBlockHeaderByLastHeightReq;
//import io.nuls.base.api.provider.Result;
import io.nuls.base.api.provider.block.facade.BlockHeaderData;

import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.lang.System;
import org.javatuples.*;
import io.nuls.base.api.provider.ServiceManager;
import io.nuls.base.api.provider.block.BlockService;


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

    /**
     *
     * @param theREQUEST : request
     * @return Result
     */
    @Path("sendMail")
    @Produces(MediaType.APPLICATION_JSON)
    @POST
//    @CmdAnnotation(cmd = BaseConstant.TX_VALIDATOR, version = 1.0, description = "")
//    @Parameter(parameterName = "chainId", parameterType = "int")
//    @Parameter(parameterName = "txList", parameterType = "List")
//    @Parameter(parameterName = "blockHeader", parameterType = "String")
    public Result<String> sendMail(SendMailReq theREQUEST) {
        return call(() -> {
            Objects.requireNonNull(theREQUEST.getSenderAddress(), "sender address can't null");  //sender
            Objects.requireNonNull(theREQUEST.getMailAddress(), "mail address can't null");  // receiver
            Objects.requireNonNull(theREQUEST.getPassword(), "sender address password can't null");

            String senderAddyStr = theREQUEST.getSenderAddress();
            String recMailAddyStr = theREQUEST.getMailAddress();
            String password = theREQUEST.getPassword();
            String count = theREQUEST.getTitle();
            int chainId = config.getChainId();
            int assetId = config.getAssetId();
            byte[] receiverAddy_BYTES = senderAddyStr.getBytes();
            byte[] senderAddy_BYTES = recMailAddyStr.getBytes();
            Optional<MailAddressData> recAddy_OPT, senderAddy_OPT;
            senderAddy_OPT = mailAddressService.getMailAddress(senderAddyStr);
            recAddy_OPT = mailAddressService.getMailAddress(recMailAddyStr);

            BigInteger itemCOUNT_BI = new BigInteger(count);
            BigInteger costPerItem = BigInteger.valueOf(Long.parseLong("0000000112221111"));
            BigInteger firstCOST = costPerItem.multiply(itemCOUNT_BI);  // subtract from sender, add to receiver

            // Ennead is python-like object from org.javatuples
            Ennead <String, String, String, Optional<MailAddressData>, Optional<MailAddressData>,
                    byte[],byte[], BigInteger, BigInteger> mainObject_JTUP;

            mainObject_JTUP = new Ennead<>
                    (password, senderAddyStr, recMailAddyStr,
                            senderAddy_OPT, recAddy_OPT,
                            senderAddy_BYTES, receiverAddy_BYTES, itemCOUNT_BI, firstCOST);

            AccountBalance senderAcctBal_AB = legderTools.getBalanceAndNonce(chainId, senderAddyStr, chainId, assetId);
            System.out.println("nms senderBal before signing:  " + senderAcctBal_AB);
            Account account = accountTools.getAccountByAddress(recMailAddyStr);

            Transaction the_TX = createSendMailTransaction(theREQUEST,  mainObject_JTUP);

            Transaction tx2 = signTransaction(the_TX, account, password);


            long blockHeight = tx2.getBlockHeight();
            BlockService blockService = ServiceManager.get(BlockService.class);

            io.nuls.base.api.provider.Result<BlockHeaderData> blockHeaderD;
            ServiceManager.init(2, Provider.ProviderType.RPC);
            //blockHeaderD = blockService.getBlockHeaderByHeight(new GetBlockHeaderByHeightReq(blockHeight));

            AccountBalance newSenderBal_AB = legderTools.getBalanceAndNonce(chainId, senderAddyStr, chainId, assetId);
            BigInteger senderAvailBal_BI = newSenderBal_AB.getAvailable();

           // int x = io.nuls.txhander.SendMailProcessor.commit(chainId, tx2, blockHeaderDataResult.getData());

            System.out.println("nms sendBal after signing:  " + senderAvailBal_BI);

            String txHash_STR = tx2.getHash().toHex();
            Result finalResult = new Result<>(txHash_STR);
            finalResult.setSuccess(true);

            BigDecimal sendBalBD = new BigDecimal(senderAvailBal_BI,8);
            String balanceString = String.valueOf(sendBalBD);

            System.out.println("nms sendBal after transaction:  " + balanceString);

            finalResult.setMsg(balanceString);
            return finalResult;
        });
    }

    /**
     *
     */
    private Transaction createSendMailTransaction(SendMailReq request,
              Ennead<String, String,   String,
                      Optional<MailAddressData>, Optional<MailAddressData>,
                      byte[],byte[], BigInteger, BigInteger> myGroup )
            throws IOException, NulsException {

        int chainId = config.getChainId();
        int assetId = config.getAssetId();

        String senderAddy_STR = myGroup.getValue1();
        String receiverAddy_STR = myGroup.getValue2();
        Optional<MailAddressData> senderAddyData_OPT = myGroup.getValue3();
        Optional<MailAddressData> recAddressData_OPT = myGroup.getValue4();
        byte[] senderAddressBytes = myGroup.getValue5();
        byte[] receiverAddressBytes = myGroup.getValue6();

        if (senderAddyData_OPT.isEmpty()) {
            throw new NulsRuntimeException(CommonCodeConstanst.PARAMETER_ERROR, "can't find sender address: " + senderAddy_STR);
        }
        if (recAddressData_OPT.isEmpty()) {
            throw new NulsRuntimeException(CommonCodeConstanst.PARAMETER_ERROR, "can't find receiver address: " + receiverAddy_STR);
        }
        if (Arrays.equals(receiverAddressBytes, senderAddressBytes)) {
            throw new NulsRuntimeException(CommonCodeConstanst.PARAMETER_ERROR, "sender equals receiver");
        }
        Account account = new Account();

        Transaction tx = new Transaction();
        String a = account.getEncryptedPrikeyHex();
        String h = account.getPubkeyHex();

        tx.setType(Constant.TX_TYPE_SEND_MAIL);
        tx.setTime(NulsDateUtils.getCurrentTimeSeconds());

        byte[] txData = buildTxData(myGroup);
        byte[] cd = buildCoinData(tx, myGroup);

        tx.setTxData(txData);
        tx.setCoinData(cd);

        System.out.println("nms transaction signature in Transaction(): " +
                Arrays.toString(tx.getTransactionSignature()));

        return tx;
    }


    private byte[] buildTxData(Ennead<String, String, String,
            Optional<MailAddressData>, Optional<MailAddressData>,
            byte[], byte[],
            BigInteger, BigInteger> myGroup) throws IOException {

        Optional<MailAddressData> senderAddyData_OPT = myGroup.getValue3();
        Optional<MailAddressData> recAddressData_OPT = myGroup.getValue4();
        byte[] senderAddress_BTS = myGroup.getValue5();
        byte[] receiverAddress_BTS = myGroup.getValue6();
        MailAddressData sendAdd_DATA = senderAddyData_OPT.get();
        if (senderAddyData_OPT.isEmpty()) {
            throw new NulsRuntimeException(CommonCodeConstanst.PARAMETER_ERROR, "can't find sender address: " + senderAddyData_OPT);
        }
        MailAddressData recAdd_DATA = recAddressData_OPT.get();
        String senderPubKey_STR = sendAdd_DATA.getPubKey();
        String recPubKey_STR = recAdd_DATA.getPubKey();

        ECKey key = new ECKey();
        byte[] pubkey = key.getPubKey();
        byte[] privKey_BYTES = key.getPrivKeyBytes();

        byte[] sender_ECK = ECIESUtil.encrypt(HexUtil.decode(senderPubKey_STR), privKey_BYTES);
        byte[] receiver_ECK = ECIESUtil.encrypt(HexUtil.decode(recPubKey_STR), privKey_BYTES);
        byte[] daysContent_BYTES = myGroup.getValue7().toString().getBytes(StandardCharsets.UTF_8);
        byte[] countTitle_BYTES = myGroup.getValue8().toString().getBytes(StandardCharsets.UTF_8);

        MailContent content = new MailContent();
        content.setContent(ECIESUtil.encrypt(pubkey, daysContent_BYTES));
        content.setTitle(ECIESUtil.encrypt(pubkey, countTitle_BYTES));
        content.setReceiverAddress(receiverAddress_BTS);
        content.setReceiverKey(receiver_ECK);
        content.setSenderAddress(senderAddress_BTS);
        content.setSenderKey(sender_ECK);
        content.setTimestamp(System.currentTimeMillis());
        return content.serialize();
    }


    private byte[] buildCoinData(Transaction tx,
                 Ennead<String, String, String, Optional<MailAddressData>, Optional<MailAddressData>,
                 byte[],byte[], BigInteger, BigInteger> myGroup)
                 throws IOException, NulsException {
        int chId = config.getChainId();
        int asId = config.getAssetId();
        String sendAddyStr = myGroup.getValue1();
        byte[] senderAddressBytes = myGroup.getValue5();
        byte[] receiverAddressBytes = myGroup.getValue6();
        BigInteger firstCost = myGroup.getValue8();
        byte locked = 0;

        AccountBalance sendAcctBal_OBJ = legderTools.getBalanceAndNonce(chId, sendAddyStr, chId, asId);
        BigInteger avail_BI =  sendAcctBal_OBJ.getAvailable();
        byte[] nonce = RPCUtil.decode(sendAcctBal_OBJ.getNonce());
        CoinFrom coinFrom = new CoinFrom();

        coinFrom.setAddress(senderAddressBytes);
        coinFrom.setAssetsChainId(chId);
        coinFrom.setAssetsId(asId);
        coinFrom.setAmount(firstCost);
        coinFrom.setLocked(locked);
        coinFrom.setNonce(nonce);

        CoinTo coinTo = new CoinTo(receiverAddressBytes, chId, asId, firstCost);
        coinTo.setAddress(receiverAddressBytes);

        int txSize = tx.size() + coinFrom.size() + coinTo.size() + P2PHKSignature.SERIALIZE_LENGTH;
        BigInteger sizeBasedTxFee_BI = TransactionFeeCalculator.getNormalTxFee(txSize);
        BigInteger totalCostPlusFee_BI = firstCost.add(sizeBasedTxFee_BI);

        if (avail_BI.min(totalCostPlusFee_BI).equals(avail_BI)){
            throw new NulsRuntimeException(CommonCodeConstanst.FAILED, "insufficient fee");
        }
        coinFrom.setAmount(totalCostPlusFee_BI);

        CoinData coinData = new CoinData();
        coinData.setFrom(List.of(coinFrom));
        coinData.setTo(List.of(coinTo));

        return coinData.serialize();
    }

}
