/**
 * Created by sargissargsyan on 4/20/14.
 */
package gatf.model.commands {
import flash.filesystem.File;

import gatf.controller.signal.LogDataSignal;

public class GenerateSingleATFCommand extends ATFCommand {
    private var _data:Object;

    public function GenerateSingleATFCommand(pngFile:File, logDataSignal:LogDataSignal, data:Object) {
        super(pngFile, logDataSignal);
        _data = data;
    }

    override public function execute(callback:Function):void {
        super.execute(callback);
        var processArgs:Vector.<String> = new Vector.<String>();
        if (_data.blockCompression) {
            processArgs.push("-c");
            switch (true) {
                case _data.blockCompressedTextureDXT1:
                    processArgs.push("d");
                    break;
                case _data.blockCompressedTextureETC1:
                    processArgs.push("e");
                    break;
                case _data.blockCompressedTexturePVRTC4bpp:
                    processArgs.push("p");
                    break;
                default :
                    break;
            }
        }
        else {
            processArgs.push("-q");
            processArgs.push(_data.quantization);
            processArgs.push("-f");
            processArgs.push(_data.flexBits);
            switch (true) {
                case _data.colorSpacing0:
                    processArgs.push("-0");
                    break;
                case _data.colorSpacing2:
                    processArgs.push("-2");
                    break;
                case _data.colorSpacing4:
                    processArgs.push("-4");
                    break;
            }
        }
        if (_data.jpeg_xr_lzma_compression) {
            processArgs.push("-r");
        }
        processArgs.push("-n");
        processArgs.push(_data.mipMapRange.lowValue + "," + _data.mipMapRange.highValue);
        processArgs.push("-i");
        processArgs.push(_pngFile.nativePath);
        processArgs.push("-o");
        processArgs.push(_pngFile.parent.nativePath + File.separator + getATFFileName());
        crateProcess("png2atf", processArgs);
    }


}

}
