/**
 * Created by sargissargsyan on 4/19/14.
 */
package gatf.controller.bootstrap {
import gatf.view.ApplicationView;
import gatf.view.ApplicationViewMediator;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;

public class BootstrapViewMediators {
    public function BootstrapViewMediators(mediatorMap:IMediatorMap) {
        mediatorMap.map(ApplicationView).toMediator(ApplicationViewMediator);
    }
}
}
