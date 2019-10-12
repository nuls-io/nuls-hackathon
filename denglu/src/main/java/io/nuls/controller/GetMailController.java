package io.nuls.controller;

import java.io.IOException;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import io.nuls.Config;
import io.nuls.base.basic.AddressTool;
import io.nuls.controller.core.BaseController;
import io.nuls.controller.core.BaseResult;
import io.nuls.controller.core.Result;
import io.nuls.controller.vo.GetMailListReq;
import io.nuls.controller.vo.MailAddressData;
import io.nuls.controller.vo.MailContentData;
import io.nuls.controller.vo.ViewMailReq;
import io.nuls.core.core.annotation.Autowired;
import io.nuls.core.core.annotation.Component;
import io.nuls.core.crypto.ECKey;
import io.nuls.core.crypto.HexUtil;
import io.nuls.core.exception.CryptoException;
import io.nuls.core.exception.NulsException;
import io.nuls.rpctools.AccountTools;
import io.nuls.service.MailAddressService;
import io.nuls.service.SendMailService;

/**
 * @Author: zhoulijun
 * @Time: 2019-06-11 21:03
 * @Description: 功能描述
 */
@Path("/")
@Component
public class GetMailController implements BaseController {

    @Autowired
    Config config;

    @Autowired
    AccountTools accountTools;

    @Autowired
    SendMailService sendMailService;

    @Autowired
    MailAddressService mailAddressService;

    /**
     * 生成一个邮件收件地址
     * 需要扣除1个NULS作为手续费
     *
     * @param req
     * @return
     */
    @Path("viewMail")
    @Produces(MediaType.APPLICATION_JSON)
    @POST
    public BaseResult viewMail(ViewMailReq req){
        return call(()->{
            Objects.requireNonNull(req.getMailAddress(),"address can't null");
            Objects.requireNonNull(req.getPassword(),"sender address password can't null");
            Objects.requireNonNull(req.getHash(),"hash can't null");
            Optional<MailAddressData> optionalMailAddress = mailAddressService.getMailAddressPubKey(req.getMailAddress());
            if(optionalMailAddress.isEmpty()){
                return new Result(0, "not found mail");
            }
            String address = optionalMailAddress.get().getAddress();
            String priKey = accountTools.getAddressPriKey(config.getChainId(),address,req.getPassword());
            ECKey ecKey = ECKey.fromPrivate(HexUtil.decode(priKey));
            MailContentData mcd = sendMailService.getMailContent(req.getHash(),ecKey,AddressTool.getAddress(address));
            mcd.setHash(req.getHash());
            return new Result(mcd);
        });
    }


    /**
     * 生成一个邮件收件地址
     * 需要扣除1个NULS作为手续费
     *
     * @param req
     * @return
     */
    @Path("getSendList")
    @Produces(MediaType.APPLICATION_JSON)
    @POST
    public BaseResult getSendList(GetMailListReq req){
        return call(()->getMailList(req,true));
    }

    /**
     * 生成一个邮件收件地址
     * 需要扣除1个NULS作为手续费
     *
     * @param req
     * @return
     */
    @Path("getReceiveList")
    @Produces(MediaType.APPLICATION_JSON)
    @POST
    public BaseResult getReceiveList(GetMailListReq req){
        return call(()-> getMailList(req,false));
    }

    public Result getMailList(GetMailListReq req,boolean isSender) throws NulsException, IOException, CryptoException {
        Objects.requireNonNull(req.getAddress(),"address can't null");
        Objects.requireNonNull(req.getPassword(),"sender address password can't null");
        String priKey = accountTools.getAddressPriKey(config.getChainId(),req.getAddress(),req.getPassword());
        ECKey ecKey = ECKey.fromPrivate(HexUtil.decode(priKey));
        List<MailContentData> res = sendMailService.getMailList(req.getAddress(),ecKey,isSender);
        return new Result(res);
    }

}
