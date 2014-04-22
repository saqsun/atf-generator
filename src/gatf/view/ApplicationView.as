/**
 * Created by sargissargsyan on 4/16/14.
 */
package gatf.view {
import com.bit101.components.CheckBox;
import com.bit101.components.HBox;
import com.bit101.components.HRangeSlider;
import com.bit101.components.HUISlider;
import com.bit101.components.Label;
import com.bit101.components.PushButton;
import com.bit101.components.RadioButton;
import com.bit101.components.Style;
import com.bit101.components.TextArea;
import com.bit101.components.VBox;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filesystem.File;

import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;

public class ApplicationView extends Sprite {
    private var _onButtonAddPNGsClick:ISignal;
    private var _onButtonGenerateATFsClick:ISignal;
    private var _onCheckBoxBlockBasedCompressionClick:ISignal;
    private var _generalConfigsBox:VBox;
    private var _nonBlockCompressionConfigsBox:VBox;
    private var _blockCompressedTextureSet:VBox;
    private var _output:TextArea;
    private var _blockCompressionCheckBox:CheckBox;
    private var _mipMapRangeSlider:HRangeSlider;
    private var _quantizationSlider:HUISlider;
    private var _blockCompressedTexturePVRTC4bppRadioButton:RadioButton;
    private var _blockCompressedTextureDXT1RadioButton:RadioButton;
    private var _blockCompressedTextureETC1RadioButton:RadioButton;
    private var _blockCompressedTextureAllRadioButton:RadioButton;
    private var _JPEG_XR_LZMACompressionCheckBox:CheckBox;
    private var _flexBitsSlider:HUISlider;
    private var _colorSpacing4RadioButton:RadioButton;
    private var _colorSpacing2RadioButton:RadioButton;
    private var _colorSpacing0RadioButton:RadioButton;

    public function ApplicationView() {
        Style.setStyle(Style.DARK);
        initSignals();
        addEventListener(Event.ADDED_TO_STAGE, viewAddedToStageHandler);
        trace(this, "constructor...");
    }

    private function initSignals():void {
        _onButtonAddPNGsClick = new Signal();
        _onButtonGenerateATFsClick = new Signal();
        _onCheckBoxBlockBasedCompressionClick = new Signal(Boolean);
    }

    private function viewAddedToStageHandler(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, viewAddedToStageHandler);
        var mainBox:VBox = new VBox(this, 10, 10);
        mainBox.spacing = 30;

        var buttonBox:HBox = new HBox(mainBox);

        var configBox:HBox = new HBox(mainBox);
        configBox.spacing = 172;

        var outputBox:HBox = new HBox(mainBox);

        buildButtonBox(buttonBox);
        buildConfigBox(configBox);
        buildOutputBox(outputBox);

    }

    private function buildOutputBox(outputBox:HBox):void {
        _output = new TextArea(outputBox, 0, 0);
        _output.height = 189;
        _output.width = 580;
        _output.editable = false;
    }

    private function buildButtonBox(buttonBox:HBox):void {
        new PushButton(buttonBox, 0, 0, "Add PNGs", addPNGsButtonHandler);
        new PushButton(buttonBox, 0, 0, "Generate ATFs", generateATFsButtonHandler);
    }

    private function generateATFsButtonHandler(event:MouseEvent):void {
        _onButtonGenerateATFsClick.dispatch();
    }

    private function addPNGsButtonHandler(event:MouseEvent):void {
        _onButtonAddPNGsClick.dispatch();
    }

    private function buildConfigBox(configBox:HBox):void {
        _generalConfigsBox = new VBox(configBox);
        _generalConfigsBox.spacing = 25;
        _nonBlockCompressionConfigsBox = new VBox(configBox);
        _nonBlockCompressionConfigsBox.spacing = 10;
        buildGeneralConfigsBox();
        buildNonBlockCompressionConfigsBox();
    }

    private function buildNonBlockCompressionConfigsBox():void {
        _quantizationSlider = new HUISlider(_nonBlockCompressionConfigsBox, 0, 0, "Quantization (-q)");
        _quantizationSlider.tick = 1;
        _quantizationSlider.minimum = 0;
        _quantizationSlider.maximum = 180;

        _flexBitsSlider = new HUISlider(_nonBlockCompressionConfigsBox, 0, 0, "Trim flex bits (-f)");
        _flexBitsSlider.tick = 1;
        _flexBitsSlider.minimum = 0;
        _flexBitsSlider.maximum = 15;

        new Label(_nonBlockCompressionConfigsBox, 0, 0, "Color spacing");
        _colorSpacing4RadioButton = new RadioButton(_nonBlockCompressionConfigsBox, 20, 0, "4:4:4 (-4)");
        _colorSpacing2RadioButton = new RadioButton(_nonBlockCompressionConfigsBox, 20, 0, "4:2:2 (-2)");
        _colorSpacing0RadioButton = new RadioButton(_nonBlockCompressionConfigsBox, 20, 0, "4:2:0 (-0)");
    }

    private function buildGeneralConfigsBox():void {
        var blockCompressedTexture:VBox = new VBox(_generalConfigsBox);
        blockCompressedTexture.spacing = 10;

        _blockCompressionCheckBox = new CheckBox(blockCompressedTexture, 0, 0, "Block based compression (-c)", blockBasedCompressionCheckBoxHandler);
        _blockCompressedTextureSet = new VBox(blockCompressedTexture, 20);
        _blockCompressedTextureSet.spacing = 7;

        _blockCompressedTexturePVRTC4bppRadioButton = new RadioButton(_blockCompressedTextureSet, 0, 0, "PVRTC4bpp (p)");
        _blockCompressedTextureDXT1RadioButton = new RadioButton(_blockCompressedTextureSet, 0, 0, "DXT1 (d)");
        _blockCompressedTextureETC1RadioButton = new RadioButton(_blockCompressedTextureSet, 0, 0, "ETC1 (e)");
        _blockCompressedTextureAllRadioButton = new RadioButton(_blockCompressedTextureSet, 0, 0, "All");

        _JPEG_XR_LZMACompressionCheckBox = new CheckBox(_generalConfigsBox, 0, 0, "Compress texture using JPEG-XR+LZMA (-r)");

        var mipMapBox:HBox = new HBox(_generalConfigsBox);
        new Label(mipMapBox, 0, -4, "Mip map levels (-n)");
        _mipMapRangeSlider = new HRangeSlider(mipMapBox, 0, 0);
        _mipMapRangeSlider.maximum = 10;
    }

    private function blockBasedCompressionCheckBoxHandler(event:MouseEvent):void {
        var checkBox:CheckBox = event.target as CheckBox;
        _onCheckBoxBlockBasedCompressionClick.dispatch(checkBox.selected);
    }

    public function get onButtonAddPNGsClick():ISignal {
        return _onButtonAddPNGsClick;
    }

    public function get onButtonGenerateATFsClick():ISignal {
        return _onButtonGenerateATFsClick;
    }

    public function get onCheckBoxBlockBasedCompressionClick():ISignal {
        return _onCheckBoxBlockBasedCompressionClick;
    }

    public function get blockCompressionCheckBoxValue():Boolean {
        return _blockCompressionCheckBox.selected;
    }

    public function get blockCompressedTexturePVRTC4bppRadioButtonValue():Boolean {
        return _blockCompressedTexturePVRTC4bppRadioButton.selected;
    }

    public function disableNonBlockCompressionOptions():void {
        _nonBlockCompressionConfigsBox.enabled = false;
    }

    public function enableNonBlockCompressionOptions():void {
        _nonBlockCompressionConfigsBox.enabled = true;
    }

    public function enableBlockCompressedTextureSet():void {
        _blockCompressedTextureSet.enabled = true;
        if (_blockCompressedTexturePVRTC4bppRadioButton.selected || _blockCompressedTextureDXT1RadioButton.selected ||
                _blockCompressedTextureETC1RadioButton.selected || _blockCompressedTextureAllRadioButton.selected) {
            return;
        }
        _blockCompressedTextureAllRadioButton.selected = true;
    }

    public function disableBlockCompressedTextureSet():void {
        _blockCompressedTextureSet.enabled = false;
    }

    public function logData(data:String):void {
        _output.text = data + File.lineEnding + _output.text;
        _output.autoHideScrollBar = true;
    }

    public function setMipmapRangeValue(start:int, end:int):void {
        _mipMapRangeSlider.lowValue = start;
        _mipMapRangeSlider.highValue = end;
    }

    public function setQuantizationLevelValue(level:int):void {
        _quantizationSlider.value = level;
    }


    public function get blockCompressedTextureDXT1RadioButtonValue():Boolean {
        return _blockCompressedTextureDXT1RadioButton.selected;
    }

    public function get blockCompressedTextureETC1RadioButtonValue():Boolean {
        return _blockCompressedTextureETC1RadioButton.selected;
    }

    public function get JPEG_XR_LZMACompressionCheckBoxValue():Boolean {
        return _JPEG_XR_LZMACompressionCheckBox.selected;
    }

    public function get mipMapRangeSliderValue():Object {
        return {
            lowValue: _mipMapRangeSlider.lowValue,
            highValue: _mipMapRangeSlider.highValue
        };
    }

    public function get quantizationSliderValue():int {
        return _quantizationSlider.value;
    }

    public function get flexBitsSliderValue():int {
        return _flexBitsSlider.value;
    }

    public function get colorSpacing4RadioButtonValue():Boolean {
        return _colorSpacing4RadioButton.selected;
    }

    public function get colorSpacing2RadioButtonValue():Boolean {
        return _colorSpacing2RadioButton.selected;
    }

    public function get colorSpacing0RadioButtonValue():Boolean {
        return _colorSpacing0RadioButton.selected;
    }
}
}
