/**
 * Created by sargissargsyan on 4/19/14.
 */
package gatf.application {
import flash.display.DisplayObjectContainer;

import gatf.application.config.GATFContextConfig;
import gatf.view.ApplicationView;

import robotlegs.bender.bundles.mvcs.MVCSBundle;
import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;
import robotlegs.bender.framework.impl.Context;

public class GATFApplication {
    private var _view:ApplicationView;
    //noinspection JSFieldCanBeLocal
    private var _context:Context;
    private var _rootDisplayObjectContainer:DisplayObjectContainer;

    public function GATFApplication(rootDisplayObjectContainer:DisplayObjectContainer) {
        _rootDisplayObjectContainer = rootDisplayObjectContainer;
        _view = new ApplicationView();
        _context = new Context();
        _context.afterInitializing(onAfterContextInitialize);
        _context.install(MVCSBundle, SignalCommandMapExtension);
        _context.configure(GATFContextConfig, new ContextView(_view));
        _context.initialize();
    }

    private function onAfterContextInitialize():void {
        _rootDisplayObjectContainer.addChild(_view);
    }

}
}
