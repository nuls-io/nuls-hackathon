package io.nuls;

import io.nuls.base.api.provider.Provider;
import io.nuls.base.api.provider.ServiceManager;
import io.nuls.controller.core.WebServerManager;
import io.nuls.core.core.annotation.Autowired;
import io.nuls.core.core.annotation.Component;
import io.nuls.core.rpc.model.ModuleE;
import io.nuls.core.rpc.modulebootstrap.Module;
import io.nuls.core.rpc.modulebootstrap.RpcModuleState;
import io.nuls.rpc.TransactionTools;

import java.io.File;

/**
 * @author: nmschorr from zhoulijun
 * @date: 2019-09-24
 * @Description:  Blockparty - Nuls Hackathon entry
 */
@Component
public class MyModule {

    @Autowired
    Config config;

    @Autowired
    TransactionTools transactionTools;

    public RpcModuleState startModule(String moduleName){

        File file = new File(config.getDataPath());
        if(!file.exists()){
            file.mkdir();
        }

        ServiceManager.init(2, Provider.ProviderType.RPC);

        transactionTools.registerTx(moduleName,Constant.TX_TYPE_CREATE_MAIL_ADDRESS,Constant.TX_TYPE_SEND_MAIL);
        WebServerManager.getInstance().startServer("0.0.0.0", 9999);
        return RpcModuleState.Running;
    }

    public Module[] declareDependent() {
        return new Module[]{
                Module.build(ModuleE.LG),
                Module.build(ModuleE.TX),
                Module.build(ModuleE.NW)
        };
    }
}
