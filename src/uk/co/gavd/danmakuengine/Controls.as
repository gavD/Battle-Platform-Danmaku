import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

var _keys:Array = new Array();
stage.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
stage.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);

function handleKeyDown(evt:KeyboardEvent):void {
    if (_keys.indexOf(evt.keyCode) == -1) {
        _keys.push(evt.keyCode);
    }
}

function handleKeyUp(evt:KeyboardEvent):void {
    var i:int = _keys.indexOf(evt.keyCode);

    if (i > -1) {
        _keys.splice(i, 1);
    }
}

function isKeyPressed(key:int):Boolean {
    return _keys.indexOf(key) > -1;
}