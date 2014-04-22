/**
 * Created by sargissargsyan on 4/19/14.
 */
package gatf.controller.command {
import flash.filesystem.File;

import gatf.model.ATFGeneratorModel;

import robotlegs.bender.bundles.mvcs.Command;

public class SelectPNGsCommand extends Command {
    [Inject]
    public var _atfGeneratorModel:ATFGeneratorModel;

    [Inject]
    public var _pngFiles:Vector.<File>;

    override public function execute():void {
        trace(this, "execute");
        _atfGeneratorModel.selectPNGs(_pngFiles);
    }


}
}
