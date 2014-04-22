/**
 * Created by sargissargsyan on 4/19/14.
 */
package gatf.controller.bootstrap {
import gatf.controller.command.AddPNGsCommand;
import gatf.controller.command.GenerateATFsCommand;
import gatf.controller.command.SelectPNGsCommand;
import gatf.controller.signal.AddPNGsSignal;
import gatf.controller.signal.GenerateATFsSignal;
import gatf.controller.signal.SelectPNGsSignal;

import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;

public class BootstrapCommands {
    public function BootstrapCommands(signalCommandMap:ISignalCommandMap) {
        signalCommandMap.map(AddPNGsSignal).toCommand(AddPNGsCommand);
        signalCommandMap.map(SelectPNGsSignal).toCommand(SelectPNGsCommand);
        signalCommandMap.map(GenerateATFsSignal).toCommand(GenerateATFsCommand);
    }
}
}
