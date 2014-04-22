/**
 * Created by sargissargsyan on 4/20/14.
 */
package gatf.model.commands {
import flash.desktop.NativeProcess;
import flash.desktop.NativeProcessStartupInfo;
import flash.events.NativeProcessExitEvent;
import flash.events.ProgressEvent;
import flash.filesystem.File;
import flash.utils.IDataInput;

import gatf.controller.signal.LogDataSignal;

public class ATFCommand implements IATFCommand {
    protected var _pngFile:File;
    protected var _callback:Function;
    protected var _logDataSignal:LogDataSignal;

    public function ATFCommand(pngFile:File, logDataSignal:LogDataSignal) {
        _pngFile = pngFile;
        _logDataSignal = logDataSignal;
    }

    public function execute(callback:Function):void {
        _callback = callback;
    }

    protected function crateProcess(execName:String, processArgs:Vector.<String>):void {
        var nativeProcessStartupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
        nativeProcessStartupInfo.executable = File.applicationDirectory.resolvePath(execName);
        nativeProcessStartupInfo.arguments = processArgs;
        var process:NativeProcess = new NativeProcess();
        process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, processStandardOutputDataHandler);
        process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, processStandardErrorDataHandler);
        process.addEventListener(NativeProcessExitEvent.EXIT, processExitHandler);
        process.start(nativeProcessStartupInfo);
        if (process.running) {
            process.closeInput();
        }
    }

    protected function processExitHandler(event:NativeProcessExitEvent):void {
        trace(this, "Exit process : " + event.exitCode);
        _callback(true);
    }

    protected function processStandardErrorDataHandler(event:ProgressEvent):void {
        handleProcessStandardData(event, "standardError");
    }

    protected function processStandardOutputDataHandler(event:ProgressEvent):void {
        handleProcessStandardData(event, "standardOutput");
    }

    protected function handleProcessStandardData(event:ProgressEvent, propertyName:String):void {
        var process:NativeProcess = event.target as NativeProcess;
        var data:IDataInput = process[propertyName];
        var message:String = data.readUTFBytes(data.bytesAvailable);
        _logDataSignal.dispatch(message);
        trace(this, message);
    }

    protected function getATFFileName():String {
        return _pngFile.name.substring(0, _pngFile.name.lastIndexOf(".")) + ".atf";
    }
}
}
