/**
 * Created by sargissargsyan on 4/16/14. Time: 8:40 PM
 */
package gatf.application.config {
import gatf.controller.bootstrap.BootstrapCommands;
import gatf.controller.bootstrap.BootstrapModels;
import gatf.controller.bootstrap.BootstrapServices;
import gatf.controller.bootstrap.BootstrapSignals;
import gatf.controller.bootstrap.BootstrapViewMediators;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IInjector;

public class GATFContextConfig implements IConfig {
    [Inject]
    public var _injector:IInjector;
    [Inject]
    public var _mediatorMap:IMediatorMap;
    [Inject]
    public var _signalCommandMap:ISignalCommandMap;

    public function configure():void {
        new BootstrapModels(_injector);
        new BootstrapServices(_injector);
        new BootstrapSignals(_injector);
        new BootstrapCommands(_signalCommandMap);
        new BootstrapViewMediators(_mediatorMap);
    }
}
}
