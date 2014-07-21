/**
 * Created by sargissargsyan on 4/19/14.
 */
package gatf.controller.signal {
import gatf.vo.GenerateATFVO;

import org.osflash.signals.Signal;

public class GenerateATFsSignal extends Signal {
    public function GenerateATFsSignal() {
        super(GenerateATFVO);
    }
}
}
