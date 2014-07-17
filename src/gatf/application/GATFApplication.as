/**
 * Created by sargissargsyan on 4/19/14.
 */
package gatf.application {
import gatf.application.config.GATFContextConfig;

import robotlegs.bender.bundles.mvcs.MVCSBundle;
import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;
import robotlegs.bender.framework.impl.Context;

import spark.components.Application;

public class GATFApplication extends Application {
    //noinspection JSFieldCanBeLocal
    private var _context:Context;

    public function GATFApplication() {
        _context = new Context();
        _context.afterInitializing(onAfterContextInitialize);
        _context.install(MVCSBundle, SignalCommandMapExtension);
        _context.configure(GATFContextConfig, new ContextView(this));
        _context.initialize();
    }

    private function onAfterContextInitialize():void {
    }

}
}
