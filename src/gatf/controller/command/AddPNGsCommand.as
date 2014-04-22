/**
 * Created by sargissargsyan on 4/19/14.
 */
package gatf.controller.command {
import gatf.service.PNGBrowserService;

import robotlegs.bender.bundles.mvcs.Command;

public class AddPNGsCommand extends Command {
    [Inject]
    public var _pngBrowserService:PNGBrowserService;

    override public function execute():void {
        trace(this, "execute");
        _pngBrowserService.browse();
    }


}
}
