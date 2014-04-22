/**
 * Created by sargissargsyan on 4/13/14.
 */
package {
import flash.display.Sprite;
import flash.events.Event;

import gatf.application.GATFApplication;

[SWF(width=600, height=450)]
public class Main extends Sprite {
    //noinspection JSFieldCanBeLocal
    private var _application:GATFApplication;

    public function Main() {
        super();
        addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    private function addedToStageHandler(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        _application = new GATFApplication(this);
    }
}
}
