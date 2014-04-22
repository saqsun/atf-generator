/**
 * Created by sargissargsyan on 4/19/14.
 */
package gatf.controller.signal {
import flash.filesystem.File;

import org.osflash.signals.Signal;

public class SelectPNGsSignal extends Signal {
    public function SelectPNGsSignal() {
        super(Vector.<File>);
    }
}
}
