//game.hero.addEventListener(KeyboardEvent.KEY_DOWN, game.hero.reportKeyDown);

/*
var myListener:Object = new Object();
myListener.onKeyDown = function () {
    var keyCode:Number = Key.getCode();
    if (keyCode == Key.SPACE) {
         if (theRoot.fcGameOver.readyForRestart) {
            trace("SPACE ; restart");
            theRoot.game.hero.init(true);
            theRoot.fcGameOver.play();
            return;
        } 
        if (fireReady) {
            clickTarget.fireShot();
            fireReady = false;
        }
    }    
    else if (keyCode == 80) {
        bGamePaused = !bGamePaused;
        infoPaused._visible = bGamePaused;

    } else if (keyCode == 48 || keyCode == 49 || keyCode == 50 || keyCode == 51
            || keyCode == 52 || keyCode == 53 || keyCode == 54
             || keyCode == 55
              || keyCode == 56
               || keyCode == 57
               || keyCode == 223
               || keyCode == 71) {
        // TODO only allow on debug mode
        
        var s:Number = keyCode - 49;
        if (keyCode == 48) {
            s = 9;
        }
        if (Key.isDown(Key.SHIFT)) {
            s += 10;
        }
        var tmp:MovieClip = theRoot.enemyGenerator.spawnSpecificEnemy(s, 10);
        tmp.x = theRoot.game.hero.x - theRoot.game.BGMid.x + 100;

    }
}
myListener.onKeyUp = function() {
    if (Key.getCode() == Key.SPACE) {
        fireReady = true;
    }    
}
function setListeners() {
    Key.addListener(myListener);
}
function unsetListeners() {
    Key.removeListener(myListener);
}
setListeners();
*/


import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

var _keys:Array = new Array();
stage.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
stage.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);

function handleKeyDown(evt:KeyboardEvent):void
{
    if (_keys.indexOf(evt.keyCode) == -1)
    {
        _keys.push(evt.keyCode);
    }
}

function handleKeyUp(evt:KeyboardEvent):void
{
    var i:int = _keys.indexOf(evt.keyCode);

    if (i > -1)
    {
        _keys.splice(i, 1);
    }
}

function isKeyPressed(key:int):Boolean
{
    return _keys.indexOf(key) > -1;
}
//trace("Add listener to " + game.hero);


//theRoot.bGamePaused = false;
//theRoot.hud.gotoAndPlay(2);

//theRoot.absDelete(bulletHero);


//stop();