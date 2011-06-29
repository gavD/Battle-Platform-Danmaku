﻿_quality = "LOW";

var bGamePaused:Boolean = false;
var spawningDisabled:Boolean = false; // TODO remove?


var fireReady:Boolean = true;
var myListener:Object = new Object();
myListener.onKeyDown = function () {
	var keyCode:Number = Key.getCode();
	if (keyCode == Key.SPACE) {
		 if (_root.fcGameOver.readyForRestart) {
			trace("SPACE ; restart");
			_root.game.hero.init(true);
			_root.fcGameOver.play();
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
		var tmp:MovieClip = _root.enemyGenerator.spawnSpecificEnemy(s, 10);
		tmp._x = _root.game.hero._x - _root.game.BGMid._x + 100;

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

_root.bGamePaused = false;
_root.hud.gotoAndPlay(2);

_root.absDelete(bulletHero);


stop();