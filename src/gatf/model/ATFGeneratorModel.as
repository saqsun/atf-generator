/**
 * Created by sargissargsyan on 4/20/14.
 */
package gatf.model {
import flash.filesystem.File;

import gatf.controller.signal.LogDataSignal;
import gatf.model.commands.ATFInfoCommand;
import gatf.model.commands.GenerateSingleATFCommand;

import org.spicefactory.lib.command.builder.CommandGroupBuilder;
import org.spicefactory.lib.command.builder.Commands;
import org.spicefactory.lib.command.data.CommandData;

public class ATFGeneratorModel {
    [Inject]
    public var _logDataSignal:LogDataSignal;
    private var _pngFiles:Vector.<File>;

    public function ATFGeneratorModel() {
    }

    public function selectPNGs(pngFiles:Vector.<File>):void {
        _pngFiles = pngFiles;
        for each(var png:File in _pngFiles) {
            trace(this, "PNG file '" + png.nativePath + "' selected.");
            _logDataSignal.dispatch(png.nativePath);
        }
    }

    public function generateATFs(data:Object):void {
        var sequenceCommand:CommandGroupBuilder = Commands.asSequence();
        sequenceCommand.allResults(resultHandler);
        for each(var png:File in _pngFiles) {
            sequenceCommand.add(new GenerateSingleATFCommand(png, _logDataSignal, data));
            sequenceCommand.add(new ATFInfoCommand(png, _logDataSignal));
        }
        sequenceCommand.execute();
    }

    private function resultHandler(result:CommandData):void {
        _logDataSignal.dispatch("All your ATFs successfully generated.");
        trace(this, "done : " + result);
    }
}
}

