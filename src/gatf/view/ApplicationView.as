/**
 * Created by sargissargsyan on 4/16/14.
 */
package gatf.view {
import flash.events.MouseEvent;

import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;

public class ApplicationView extends ApplicationViewBase {
    private var _onButtonAddPNGsClick:ISignal;
    private var _onButtonGenerateATFsClick:ISignal;

    public function ApplicationView() {
        initSignals();
        trace(this, "constructor...");
    }

    private function initSignals():void {
        _onButtonAddPNGsClick = new Signal();
        _onButtonGenerateATFsClick = new Signal();
    }

    public function get onButtonAddPNGsClick():ISignal {
        return _onButtonAddPNGsClick;
    }

    public function get onButtonGenerateATFsClick():ISignal {
        return _onButtonGenerateATFsClick;
    }

    override protected function addPNGsButtonClickHandler(event:MouseEvent):void {
        _onButtonAddPNGsClick.dispatch();
    }

    override protected function generateATFsButtonClickHandler(event:MouseEvent):void {
        _onButtonGenerateATFsClick.dispatch();
    }

    public function get blockCompression():Boolean {
        return _blockCompressionCheckBox.selected;
    }

    public function get blockCompressedTextureCompression():String {
        return String(_radioBtnGroup.selectedValue);
    }

    public function get jpeg_xr_lzma_compression():Boolean {
        return _JPEG_XR_LZMACompressionCheckBox.selected;
    }

    public function get mipMapLevelStart():int {
        return _mipMapLevelStartNumericStepper.value;
    }

    public function get mipMapLevelEnd():int {
        return _mipMapLevelEndNumericStepper.value;
    }

    public function get quantization():int {
        return _quantizationSlider.value;
    }

    public function get flexBits():int {
        return _flexBitsSlider.value;
    }

    public function get colorSpacing():String {
        return _colorSpacingDropDownList.selectedItem.data;
    }
}
}
