import flash.system.System;
import flash.display.MovieClip;
import flash.display.DisplayObject;
import uk.co.gavd.danmakuengine.*;
import uk.co.gavd.danmakuengine.enemies.*;
import uk.co.gavd.danmakuengine.diagnostics.*;

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
var frt:FramerateTracker = new FramerateTracker();
this.addChild(frt);

function checkMemoryUsage():void {
	trace("== MEM: " + System.totalMemory + "==");
	trace("== OBJECTS: ==");TimelineUtils.dispTree(game, 0);
}
// enable the next line to track memory usage
//var checkMemoryIntervalID:uint = setInterval(checkMemoryUsage,1000);
// eof

stop();