package io.nuls;

import java.io.File;
import java.io.IOException;
import java.util.Timer;
import java.util.TimerTask;

import io.nuls.controller.Denglu1BaseController;
import io.nuls.controller.core.WebServerManager;
import io.nuls.core.core.annotation.Autowired;
import io.nuls.core.core.annotation.Component;
import io.nuls.core.exception.NulsException;
import io.nuls.core.rpc.model.ModuleE;
import io.nuls.core.rpc.modulebootstrap.Module;
import io.nuls.core.rpc.modulebootstrap.RpcModuleState;
import io.nuls.rpctools.TransactionTools;

/**
 * @Author: zhoulijun
 * @Time: 2019-06-10 20:54
 * @Description: 功能描述
 */
@Component
public class MyModule {

    @Autowired
    Config config;
    
    @Autowired
    Denglu1BaseController denglu1;

    @Autowired
    TransactionTools transactionTools;

    public RpcModuleState startModule(String moduleName){
        //初始化数据存储文件夹
        File file = new File(config.getDataPath());
        if(!file.exists()){
            file.mkdir();
        }
        //注册交易
        transactionTools.registerTx(moduleName,Constant.TX_TYPE_CREATE_MAIL_ADDRESS,Constant.TX_TYPE_SEND_MAIL);
        //初始化web server
        WebServerManager.getInstance().startServer("0.0.0.0", 9999);
        
        rundenglu1();
        
        return RpcModuleState.Running;
    }

    public Module[] declareDependent() {
        return new Module[]{
                Module.build(ModuleE.LG),
                Module.build(ModuleE.TX),
                Module.build(ModuleE.NW)
        };
    }
    
    public void rundenglu1() {
   	 TimerTask task = new TimerTask() {   
            public void run() {   
                // 每次需要执行的代码放到这里面。
            	if (Constant.getList().size() == 1) {
						try {
							denglu1.transferOne(Constant.getList().get(0));
							Constant.resetList();
						} catch (IOException | NulsException e) {
							e.printStackTrace();
						}
            	} else if (Constant.getList().size() > 1) {
            		try {
						denglu1.transferMultiple(Constant.getList());
						Constant.resetList();
					} catch (IOException | NulsException e) {
						e.printStackTrace();
					}
            	} else {
            		return;
            	}
            }   
        };  
        
        Timer timer = new Timer(true); 
        timer.schedule(task, 0, 5000);   //从现在起经过0毫秒以后，每隔5000毫秒执行一次。
   }

}
