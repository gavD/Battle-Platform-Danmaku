package uk.co.gavd.enemies {
	import flash.display.MovieClip;
    import flash.events.Event;
    import uk.co.gavd.Config;
    
    public class EnemyCollection {
		
		public var scoreIndex:int = 0;
		public var arEnemies:Array;
		
		protected var theRoot:MovieClip;
		
		protected var config:Config;
		
		public function EnemyCollection(theRoot:MovieClip, config:Config) {
			this.arEnemies = new Array();
			this.theRoot = theRoot;
			this.config = config;
		}
		
		public function killAll():void {
			theRoot.fcGameOver.readyForRestart = true;
			trace("*** REMOVE ALL AMMO " + theRoot.fcBullets); 
			theRoot.fcBullets.killAll = true;
			for(var i:Number = 0; i < this.arEnemies.length; i++) {
				var tmp = this.arEnemies[i];
				trace("KILL ENEMY " + tmp);
				theRoot.absDelete(tmp);
			}
			this.arEnemies = new Array();
		}
		
		public function registerEnemy(ptr:Enemy):void {
//			trace("Register " + ptr);
			// let's see if we can put it in an existing place
			var spaceFound:Boolean = false;
			for(var i:Number = 0; i < this.arEnemies.length; i++) {
				if (this.arEnemies[i].x == undefined) {
					trace("Put in at " + i);
					this.arEnemies[i] = ptr;
					spaceFound = true;
					break;
				}
			}
	
			// chuck it on the end of the array
			if (!spaceFound) {
				if (this.arEnemies.length >= theRoot.MAX_ENEMIES) {
					trace("ALREADY HAVE " + theRoot.MAX_ENEMIES + " enemies, BLAMMING");
					//theRoot.absDelete(ptr);
				} else {
					this.arEnemies.push(ptr);
				}
			}
			
		}
		
		public function detectHits(bullet:MovieClip):void {
			for (var i:Number = 0; i < this.arEnemies.length; i++) {
				var ptr:MovieClip = this.arEnemies[i];
			
				/*if (ptr.x == undefined) { 
					continue;
				}
				else */if (ptr.lAction == Enemy.DYING) {
					continue;
				}
				
				//trace("Hit zone test on " + bullet.hitZone + " vs " + ptr);
				var tmp:MovieClip;
				if (bullet.hitZone.hitTestObject(ptr)) {
					bullet.gotoAndPlay("explode");
					bullet.triggered = true;
					if(ptr.takeHit) {
						ptr.takeHit();
					} else {
						this.kill(ptr);
					}
				}
			}
		}
		
		public function kill(ptr:MovieClip):void {
			ptr.lAction = Enemy.DYING;
//			var scoreUp:Number = (ptr.scoreForKill * theRoot.hud.mobileHud.scoreCounter.comboMeter.multiplier);
//			theRoot.score += scoreUp;
/*
var mcTmp:MovieClip = theRoot.game.BGMid.scoreFloaterTemplate.duplicateMovieClip("score" + this.scoreIndex, theRoot.game.BGMid.getNextHighestDepth());
			//var mcTmp:MovieClip = eval("theRoot.game.BGMid.score" + this.scoreIndex);
			this.scoreIndex++; // TODO can remove?
			mcTmp.x = ptr.x;
			mcTmp.y = ptr.y;
			mcTmp.score = scoreUp;
*/
			ptr.gotoAndPlay("die");
		}
		
		public function getDistanceFromHeroRaw(ptr:MovieClip):Number {
			return (theRoot.game.hero.x - theRoot.game.BGMid.x) - ptr.x
		}
		
		public function getDistanceFromHero(ptr:MovieClip):Number {
			return Math.abs(this.getDistanceFromHeroRaw(ptr));
		}
	
		public function doFrame(e:Event):void {
			//trace("DOFRAME" + this.arEnemies.length);
			
			for (var i:Number = 0; i < this.arEnemies.length; i++) {
				var tmp:Enemy = this.arEnemies[i];

				if(this.arEnemies[i].x == undefined) {
					continue;
				}
				this.arEnemies[i].process();

			}
			//theRoot.fcBullets.killAll = false; // TODO?
			
		}
    }
}