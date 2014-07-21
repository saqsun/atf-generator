/**
 * Created by sargissargsyan on 4/20/14.
 */
package gatf.model.commands {
import flash.filesystem.File;

import gatf.controller.signal.LogDataSignal;
import gatf.vo.GenerateATFVO;

public class GenerateSingleATFCommand extends ATFCommand {
    private var _data:GenerateATFVO;

    public function GenerateSingleATFCommand(pngFile:File, logDataSignal:LogDataSignal, data:GenerateATFVO) {
        super(pngFile, logDataSignal);
        _data = data;
    }

    override public function execute(callback:Function):void {
        super.execute(callback);
        var processArgs:Vector.<String> = new Vector.<String>();
        if (_data.blockCompression) {
            processArgs.push("-c");
            if (_data.blockCompressedTextureCompression && _data.blockCompressedTextureCompression != "null") {
                processArgs.push(_data.blockCompressedTextureCompression);
            }
        }
        else {
            processArgs.push("-q");
            processArgs.push(_data.quantization);
            processArgs.push("-f");
            processArgs.push(_data.flexBits);
            if (_data.colorSpacing != "null") {
                processArgs.push(_data.colorSpacing)
            }
        }
        if (_data.jpeg_xr_lzma_compression) {
            processArgs.push("-r");
        }
        processArgs.push("-n");
        processArgs.push(_data.mipMapLevelStart + "," + _data.mipMapLevelEnd);
        processArgs.push("-i");
        processArgs.push(_pngFile.nativePath);
        processArgs.push("-o");
        processArgs.push(_pngFile.parent.nativePath + File.separator + getATFFileName());
        trace(this, processArgs.join(" "));
        crateProcess("png2atf", processArgs);
    }


}

}
