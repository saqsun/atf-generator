/**
 * Created by sargissargsyan on 4/19/14.
 */
package gatf.controller.bootstrap {
import gatf.controller.signal.LogDataSignal;

import robotlegs.bender.framework.api.IInjector;

public class BootstrapSignals {
    public function BootstrapSignals(injector:IInjector) {
        injector.map(LogDataSignal).asSingleton();
    }
}
}
