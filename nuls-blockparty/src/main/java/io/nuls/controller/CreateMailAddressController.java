package io.nuls.controller;

import io.nuls.controller.vo.CreateMailAddressReq;
import io.nuls.core.core.annotation.Component;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

/**
 * @author   : nmschorr from zhoulijun's code
 * @date : 2019-09-24
 * @Description :
 */
@Path("/")
@Component
public class CreateMailAddressController {

    @Path("createMail")
    @Produces(MediaType.APPLICATION_JSON)
    @POST
    public String createMailAddress(CreateMailAddressReq req) {
        System.out.println("nms just entered: " + "createMailAddress");
        String oBR = "{";
        String cBR = "}";
        String qT = "\"";
        String comma = ",";
        String mydata = qT + "Success" + qT;
        String mymsg = qT + "Your login request was successful." + qT;
        String successLab = "\"success\":";   // quotes around word success
        String dataLab = comma + "\"data\":";
        String msgLab = comma + "\"msg\":";
        StringBuilder result2 = new StringBuilder(oBR + successLab + true)
                .append(dataLab).append(mydata).
                 append(msgLab).append(mymsg).append(cBR);
        System.out.println("nms returning: " + result2);
        return result2.toString();
    }
}
