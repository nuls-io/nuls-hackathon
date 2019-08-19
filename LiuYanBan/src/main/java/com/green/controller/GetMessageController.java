package com.green.controller;

import com.green.controller.core.BaseController;
import com.green.controller.core.Result;
import com.green.pojo.MessagePojo;
import com.green.pojo.MessageUser;
import com.green.rpc.AccountTools;
import com.green.service.MessageService;
import com.green.utils.Config;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;

@RestController
@CrossOrigin
@RequestMapping("/getMessage")
public class GetMessageController implements BaseController {

    @Autowired
    Config config;

    @Autowired
    AccountTools accountTools;

    @Autowired
    MessageService messageService;

    @RequestMapping(value="/test",method=RequestMethod.GET)
    public Result<String> test(){
        return new Result<>("test ok");
    }


    @RequestMapping(value="/{isAll}",method=RequestMethod.GET)
    public Result<List<MessagePojo>> getMailList(@RequestBody MessageUser req, @PathVariable boolean isAll) {
        Objects.requireNonNull(req.getAddress(),"address can't null");
        Objects.requireNonNull(req.getPassword(),"sender address password can't null");
        List<MessagePojo> res = messageService.getMessageList(req.getAddress(), isAll);
        return new Result<>(res);
    }
}
