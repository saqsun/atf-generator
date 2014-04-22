/**
 * Created by sargissargsyan on 4/19/14.
 */
package gatf.view {
import gatf.controller.signal.AddPNGsSignal;
import gatf.controller.signal.GenerateATFsSignal;
import gatf.controller.signal.LogDataSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ApplicationViewMediator extends Mediator {
    [Inject]
    public var _applicationView:ApplicationView;

    [Inject]
    public var _addPNGsSignal:AddPNGsSignal;

    [Inject]
    public var _generateATFsSignal:GenerateATFsSignal;
    [Inject]
    public var _logDataSignal:LogDataSignal;

    override public function initialize():void {
        _applicationView.onButtonAddPNGsClick.add(onButtonAddPNGs);
        _applicationView.onButtonGenerateATFsClick.add(onButtonGenerateATFs);
        _applicationView.onCheckBoxBlockBasedCompressionClick.add(onCheckBoxBlockBasedCompression);
        _logDataSignal.add(onLogData);
        _applicationView.disableBlockCompressedTextureSet();
        _applicationView.setMipmapRangeValue(0, 0);
        _applicationView.setQuantizationLevelValue(30);
        trace(this, "initialize");
    }

    override public function destroy():void {
        _applicationView.onButtonAddPNGsClick.remove(onButtonAddPNGs);
        _applicationView.onButtonGenerateATFsClick.remove(onButtonGenerateATFs);
        _applicationView.onCheckBoxBlockBasedCompressionClick.remove(onCheckBoxBlockBasedCompression);
        _logDataSignal.remove(onLogData);
        trace(this, "destroy");
    }

    private function onLogData(data:String):void {
        _applicationView.logData(data);
    }

    private function onCheckBoxBlockBasedCompression(selected:Boolean):void {
        if (selected) {
            _applicationView.disableNonBlockCompressionOptions();
            _applicationView.enableBlockCompressedTextureSet();
        }
        else {
            _applicationView.enableNonBlockCompressionOptions();
            _applicationView.disableBlockCompressedTextureSet();
        }
    }

    private function onButtonGenerateATFs():void {
        var data:Object = {};
        data.blockCompression = _applicationView.blockCompressionCheckBoxValue;
        data.blockCompressedTexturePVRTC4bpp = _applicationView.blockCompressedTexturePVRTC4bppRadioButtonValue;
        data.blockCompressedTextureDXT1 = _applicationView.blockCompressedTextureDXT1RadioButtonValue;
        data.blockCompressedTextureETC1 = _applicationView.blockCompressedTextureETC1RadioButtonValue;
        data.jpeg_xr_lzma_compression = _applicationView.JPEG_XR_LZMACompressionCheckBoxValue;
        data.mipMapRange = _applicationView.mipMapRangeSliderValue;
        data.quantization = _applicationView.quantizationSliderValue;
        data.flexBits = _applicationView.flexBitsSliderValue;
        data.colorSpacing4 = _applicationView.colorSpacing4RadioButtonValue;
        data.colorSpacing2 = _applicationView.colorSpacing2RadioButtonValue;
        data.colorSpacing0 = _applicationView.colorSpacing0RadioButtonValue;
        _generateATFsSignal.dispatch(data);
    }

    private function onButtonAddPNGs():void {
        _addPNGsSignal.dispatch();
    }


}
}
