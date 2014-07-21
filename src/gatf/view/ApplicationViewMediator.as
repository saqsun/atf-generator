/**
 * Created by sargissargsyan on 4/19/14.
 */
package gatf.view {
import gatf.controller.signal.AddPNGsSignal;
import gatf.controller.signal.GenerateATFsSignal;
import gatf.controller.signal.LogDataSignal;
import gatf.vo.GenerateATFVO;

import org.spicefactory.lib.logging.LogContext;
import org.spicefactory.lib.logging.Logger;

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
        var log:Logger = LogContext.getLogger(ApplicationViewMediator);
        _applicationView.onButtonAddPNGsClick.add(onButtonAddPNGs);
        _applicationView.onButtonGenerateATFsClick.add(onButtonGenerateATFs);
        log.info("{0} initialize", this);
    }

    override public function destroy():void {
        _applicationView.onButtonAddPNGsClick.remove(onButtonAddPNGs);
        _applicationView.onButtonGenerateATFsClick.remove(onButtonGenerateATFs);
        trace(this, "destroy");
    }

    private function onButtonGenerateATFs():void {
        var data:GenerateATFVO = new GenerateATFVO();
        data.blockCompression = _applicationView.blockCompression;
        data.blockCompressedTextureCompression = _applicationView.blockCompressedTextureCompression;
        data.jpeg_xr_lzma_compression = _applicationView.jpeg_xr_lzma_compression;
        data.mipMapLevelStart = _applicationView.mipMapLevelStart;
        data.mipMapLevelEnd = _applicationView.mipMapLevelEnd;
        data.quantization = _applicationView.quantization;
        data.flexBits = _applicationView.flexBits;
        data.colorSpacing = _applicationView.colorSpacing;
        _generateATFsSignal.dispatch(data);
    }

    private function onButtonAddPNGs():void {
        _addPNGsSignal.dispatch();
    }


}
}
