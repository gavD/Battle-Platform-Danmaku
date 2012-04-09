package uk.co.gavd.danmakuengine.enemies {
	import flash.display.MovieClip;
    import flash.events.Event;
    import uk.co.gavd.danmakuengine.Config;
    import flash.media.Sound;
    import uk.co.gavd.danmakuengine.ballistics.BulletHero;
    
    public class EnemyCollection {
		
		public var scoreIndex:int = 0;
		public var arEnemies:Array;
		
		protected var theRoot:MovieClip;
		
		protected var config:Config;
		
		private var explodeWav:Sound;		
		
		
		public function EnemyCollection(theRoot:MovieClip, config:Config) {
			this.arEnemies = new Array();
			this.theRoot = theRoot;
			this.config = config;
			this.explodeWav = new ExplodeWav();
		}
		
		public function killAll():void {
			theRoot.fcGameOver.readyForRestart = true;
			for(var i:Number = 0; i < this.arEnemies.length; i++) {
				var tmp = this.arEnemies[i];
				theRoot.absDelete(tmp);
			}
			this.arEnemies = new Array();
		}
		
		public function registerEnemy(enemy:Enemy):void {
//			trace("Register " + enemy);
			// let's see if we can put it in an existing place
			var spaceFound:Boolean = false;
			for(var i:Number = 0; i < this.arEnemies.length; i++) {
				if (this.arEnemies[i].x == undefined) {
					trace("Put in at " + i);
					this.arEnemies[i] = enemy;
					spaceFound = true;
					break;
				}
			}
	
			// chuck it on the end of the array
			if (!spaceFound) {
				if (this.arEnemies.length >= theRoot.MAX_ENEMIES) {
					trace("ALREADY HAVE " + theRoot.MAX_ENEMIES + " enemies, BLAMMING");
					//theRoot.absDelete(enemy);
				} else {
					this.arEnemies.push(enemy);
				}
			}
		}
		
		public function detectHits(bullet:BulletHero):void {
			for (var i:Number = 0; i < this.arEnemies.length; i++) {
				
				if (this.arEnemies[i] == null) { 
					continue;
				}
				
				var enemy:Enemy = this.arEnemies[i];
				
				if (enemy.lAction == Enemy.DYING) {
					continue;
				}
				
				if (bullet.hitZone.hitTestObject(enemy)) {
					bullet.triggered = true;
					
					bullet.gotoAndPlay("explode");
					
					enemy.takeHit();
					return; // no point in staying in the loop if we hit something!
				}
			}
		}
		
		public function kill(enemy:MovieClip):void {
			this.explodeWav.play();

			enemy.lAction = Enemy.DYING;
//			var scoreUp:Number = (enemy.scoreForKill * theRoot.hud.mobileHud.scoreCounter.comboMeter.multiplier);
//			theRoot.score += scoreUp;
/*
var mcTmp:MovieClip = theRoot.game.BGMid.scoreFloaterTemplate.duplicateMovieClip("score" + this.scoreIndex, theRoot.game.BGMid.getNextHighestDepth());
			//var mc :MovieClip = eval("theRoot.game.BGMid.score" + this.scoreIndex);
			this.scoreIndex++; // TODO can remove?
			mcTmp.x = enemy.x;
			mcTmp.y = enemy.y;
			mcTmp.score = scoreUp;
*/
			enemy.gotoAndPlay("die");
		}
		
		public function getDistanceFromHeroRaw(enemy:MovieClip):Number {
			return (theRoot.game.hero.x - theRoot.game.BGMid.x) - enemy.x
		}
		
		public function getDistanceFromHero(enemy:MovieClip):Number {
			return Math.abs(this.getDistanceFromHeroRaw(enemy));
		}
	
		public function doFrame(e:Event):void {
			//trace("DOFRAME" + this.arEnemies.length);
		
			for (var i:Number = 0; i < this.arEnemies.length; i++) {
				if(this.arEnemies[i] == null) {
					// TODO shrink array?
					continue;
				}
				
				var enemy:Enemy = this.arEnemies[i];
				
				if(enemy.lAction == Enemy.DEAD) {
					enemy.parent.removeChild(enemy);
					enemy = null;
					this.arEnemies[i] = null;
					continue;
				}
				
				enemy.process();
			}
		}
    }
}