/**
 * Created by sargissargsyan on 4/19/14.
 */
package gatf.service {
import flash.events.Event;
import flash.events.FileListEvent;
import flash.filesystem.File;
import flash.net.FileFilter;

import gatf.controller.signal.SelectPNGsSignal;

public class PNGBrowserService {
    [Inject]
    public var _selectPNGsSignal:SelectPNGsSignal;

    public function browse():void {
        var txtFilter:FileFilter = new FileFilter("Image", "*.png");
        var fileBrowser:File = new File();
        fileBrowser.addEventListener(FileListEvent.SELECT_MULTIPLE, filesSelected);
        fileBrowser.addEventListener(Event.CANCEL, fileSelectionCancelled);
        fileBrowser.browseForOpenMultiple("Select Desired PNG File(s)", [txtFilter]);
    }

    private function fileSelectionCancelled(event:Event):void {

    }

    private function filesSelected(event:FileListEvent):void {
        _selectPNGsSignal.dispatch(Vector.<File>(event.files));
    }
}
}
