package uk.co.gavd.enemies {
	import flash.display.*;
	import uk.co.gavd.ballistics.*;
    import uk.co.gavd.Game;

    public class Enemy extends MovieClip {
	    private static var lBulletIndex:Number = 0; // TODO move to bullets?

		// TODO refactor sof
		private var prefDistToHero:Number = 120;
		private var shotOffset:Number = 0; // adjust where the bullet spawns from
		private var scoreForKill:Number = 5;
		private var fireRange:Number = 300;
		
		private var enemyFadeInRate:Number = 10;
		private var prefYFromHero:Number = 20; // how far a clip should try to get in line with the hero
		
		// ammo types
		public static var AIMATHERO:Number =  0;
		public static var BOMB:Number =  1;
		public static var FOUR_WAY:Number =  2;
		public static var SHOTGUN:Number =  3;
		public static var STRAIGHTACROSS:Number =  4;
		public static var BOMB_VERT:Number =  5; // TODO these 2 are dupes in bg play area
		public static var AMMO_ROTATING:Number =  6;  // TODO these 2 are dupes in bg play area
		public static var CLOUD:Number = 7;
		
		public static const NOTHING:Number = 0;
		public static const HOMING:Number = 1;
		public static const DYING:Number = 3;
		
		// TODO refactor eof
		
		public var lAction:Number = 0;
		public var bFacingLeft:Boolean = true;
		
				
		protected var game:Game;
		
		public function Enemy(game:Game) {
			this.game = game;
		}

		public function process():void {
			
//			if (game.hero.lAction != 0) {
//				//trace("game not in play");
//				return;
//			}
//			if (this.alpha < 100) {
//				this.alpha += this.enemyFadeInRate;
//				return;
//			}


			if (this.lAction == Enemy.DYING) {
				return;
			}
			if (this.lAction == Enemy.NOTHING) { // TODO activation?
				this.lAction = Enemy.HOMING;
			}
			else if (this.lAction == Enemy.HOMING) {
				this.handleMovementAndShooting();
			}
				
		}
		
		private function handleMovementAndShooting():void {
			this.handleMovementY();
			
			
			var targetX:Number  = game.hero.x - game.BGMid.x;
			
			this.turnAndFace(targetX);
			this.handleFiring(targetX);
//			this.handleMovementX(targetX);
		}
		
		protected function handleMovementX():void {} // TODO
		protected function handleMovementY():void {} // TODO
		
		private function turnAndFace(targetX:Number):void {
			if (this.bFacingLeft && targetX > this.x) {
				trace("LOOK RIGHT");
				this.bFacingLeft = false;
				this.scaleX = -1;
			} else if (!this.bFacingLeft && targetX < this.x) {
				trace("LOOK LEFT");
				this.bFacingLeft = true;
				this.scaleX= 1;
			}
		}
		
		private function handleFiring(targetX:Number):void {
			var distFromHero:Number = targetX - this.x;
			var lDistX:Number = Math.abs(distFromHero);
			//trace("Dist: " + lDistX + "; range : " +  theRoot.lEnemyFireRange);
			if (lDistX <= this.fireRange) { // within firing range
			trace("Do fire");
				// bombers and ground movers don't stop
				//trace("CHECK FOR STOP");
	//            if (this.enemyType == this.BOMBER || this.enemyType == this.GROUND_WALK_RIGHT)   {
	//                //trace("################DO MOVE");
	//                doMove = true;
	//            } else {
	//                doMove = false;
	//                if (lDistX < this.prefDistToHero) { // TOO CLOSE
	//                    if (targetX < this.x) {
	//                        this.x+=this.speed;
	//                    } else {
	//                        this.x-=this.speed;
	//                    }
	//                }
	//            }
				
				if(this.doFire(targetX, distFromHero)) {
					this.muzzleFlash();
				}
			}
		}
		
		protected function doFire (targetX:Number, distFromHero:Number):Boolean {
			return false;
		}
		
		protected function getNextBullet():Bullet {
			var clip:Bullet = new Bullet(game);
			//var clip:Bullet = theRoot.game.BGMid.bulletEnemy.duplicateMovieClip("bulletEnemy_" + ++Enemy.lBulletIndex, theRoot.game.BGMid.getNextHighestDepth());
			clip.x = this.x; // TODO offsetting?
			clip.y = this.y; // TODO offsetting?
			game.BGMid.addChild(clip);
			return clip;
		}
			
		
		private function muzzleFlash():void {
			/*
			var flasher:MovieClip = game.BGMid.flasher0.duplicateMovieClip("bulletEnemy_" + +
	
	+Enemy.lBulletIndex, game.BGMid.getNextHighestDepth());
			
			flasher.x = this.x;
			flasher.y = this.y;
			*/
		}
		
		private function loadHook():void {
			// for extensibility
		}
		/*
		function onLoad():void {
			//trace("ONLOAD called for enemy");
			this.loadHook();
			this.stop();
			
		}
*/
    }
}