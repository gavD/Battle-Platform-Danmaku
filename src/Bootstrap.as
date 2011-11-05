import uk.co.gavd.*;
import uk.co.gavd.enemies.*;

include "Controls.as"
		
stage.quality = StageQuality.LOW;
var theRoot:MovieClip = MovieClip(root); // TODO perhaps factor this out entirely

var conf:Config = new Config();
game.setConfig(conf);
var fcEnemies:EnemyCollection = new EnemyCollection(theRoot, conf);
var enemyGenerator:EnemyGenerator = new EnemyGenerator(game, fcEnemies, conf);
var clickTarget:Reticle = new Reticle(game, conf);
stage.addChild(clickTarget);

stage.addEventListener ( MouseEvent.MOUSE_DOWN, clickTarget.doMouseDown, false, 0, true);
stage.addEventListener ( MouseEvent.MOUSE_UP, clickTarget.doMouseUp, false, 0, true);
clickTarget.addEventListener ( Event.ENTER_FRAME, clickTarget.doFrame, false, 0, true);
game.addEventListener ( Event.ENTER_FRAME, game.doFrame, false, 0, true);
game.hero.addEventListener(Event.ENTER_FRAME,game.hero.doFrame, false, 0, true);
stage.addEventListener(Event.ENTER_FRAME, fcEnemies.doFrame, false, 0, true);

stop();