/**
 * Created by sargissargsyan on 4/20/14.
 */
package gatf.controller.bootstrap {
import gatf.model.ATFGeneratorModel;

import robotlegs.bender.framework.api.IInjector;

public class BootstrapModels {
    public function BootstrapModels(injector:IInjector) {
        injector.map(ATFGeneratorModel).asSingleton();
    }
}
}
