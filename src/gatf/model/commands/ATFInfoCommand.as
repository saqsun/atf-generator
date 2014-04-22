/**
 * Created by sargissargsyan on 4/20/14.
 */
package gatf.model.commands {
import flash.filesystem.File;

import gatf.controller.signal.LogDataSignal;

public class ATFInfoCommand extends ATFCommand {

    public function ATFInfoCommand(pngFile:File, logDataSignal:LogDataSignal) {
        super(pngFile, logDataSignal);

    }

    override public function execute(callback:Function):void {
        super.execute(callback);
        var processArgs:Vector.<String> = new Vector.<String>();
        processArgs.push("-i");
        processArgs.push(_pngFile.parent.nativePath + "/" + getATFFileName());
        crateProcess("atfinfo", processArgs);
    }


}

}
