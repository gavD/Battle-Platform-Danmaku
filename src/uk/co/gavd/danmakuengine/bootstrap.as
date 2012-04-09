import uk.co.gavd.*;
import uk.co.gavd.enemies.*;

include "Controls.as"
		
stage.quality = StageQuality.LOW;
var theRoot:MovieClip = MovieClip(root); // TODO perhaps factor this out entirely

var conf:Config = new Config();
game.setConfig(conf);
var fcEnemies:EnemyCollection = new EnemyCollection(theRoot, conf);
var enemyGenerator:EnemyGenerator = new EnemyGenerator(game, fcEnemies, conf);
var reticle:Reticle = new Reticle(game, conf);
stage.addChild(reticle);

stage.addEventListener ( MouseEvent.MOUSE_DOWN, reticle.doMouseDown, false, 0, true);
stage.addEventListener ( MouseEvent.MOUSE_UP, reticle.doMouseUp, false, 0, true);
reticle.addEventListener ( Event.ENTER_FRAME, reticle.doFrame, false, 0, true);
game.addEventListener ( Event.ENTER_FRAME, game.doFrame, false, 0, true);
game.hero.addEventListener(Event.ENTER_FRAME,game.hero.doFrame, false, 0, true);
stage.addEventListener(Event.ENTER_FRAME, fcEnemies.doFrame, false, 0, true);

// sof diagnostics
import flash.system.System;
import flash.display.MovieClip;
import flash.display.DisplayObject;

var frt:FramerateTracker = new FramerateTracker();
this.addChild(frt);
frt.visible = true;
frt.x = 1;
frt.y = 1;

// check our memory every 1 second:
function getClass(obj:Object):Class {
	return Class(getDefinitionByName(getQualifiedClassName(obj)));
}

function dispTree(sym, indent) {
	var len:int = sym.numChildren;  
	for (var i:int = 0; i < len; i++) {  
		var display:DisplayObject = sym.getChildAt(i);  
		
		var s:String = "";
		for(var n:int = 0; n <= indent; n++) {
			s += " ";
		}
		
		trace(s + display.name + "[" + getClass(display) + "]");  
		if(display is flash.display.MovieClip) {
			dispTree(display, indent + 1);
		}
	}  
}

function checkMemoryUsage():void {
	//trace("== MEM: " + System.totalMemory + "==");
	//trace("== OBJECTS: ==");dispTree(game, 0);
}
var checkMemoryIntervalID:uint = setInterval(checkMemoryUsage,1000);
// eof

stop();