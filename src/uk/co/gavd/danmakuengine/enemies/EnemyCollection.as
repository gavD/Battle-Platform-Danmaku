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
				kill(this.arEnemies[i]);
				this.arEnemies[i] = null
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
				
				if(enemy.checkHit(bullet)) {
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

			enemy.gotoAndPlay("die");
		}
		
		public function onFrame(e:Event):void {
			//trace("onFrame" + this.arEnemies.length);
		
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