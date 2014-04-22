/**
 * Created by sargissargsyan on 4/19/14.
 */
package gatf.controller.bootstrap {
import gatf.service.PNGBrowserService;

import robotlegs.bender.framework.api.IInjector;

public class BootstrapServices {
    public function BootstrapServices(injector:IInjector) {
        injector.map(PNGBrowserService).asSingleton();
    }
}
}
