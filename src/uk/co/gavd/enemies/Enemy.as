package uk.co.gavd.enemies {
	import flash.display.*;
	import uk.co.gavd.ballistics.*;
    import uk.co.gavd.Game;
	import flash.events.Event;

    public class Enemy extends MovieClip {
	    private static var lBulletIndex:Number = 0; // TODO move to bullets?

		// TODO refactor sof
		protected var prefDistToHero:Number = 120;
		protected var shotOffset:Number = 0; // adjust where the bullet spawns from
		protected var scoreForKill:int = 5;
		protected var fireRange:Number = 300;
		
		protected var hp:Number = 5;
		protected var prefYFromHero:Number = 20; // how far a clip should try to get in line with the hero
		
		// ammo types
		public static var AIMATHERO:int =  0;
		public static var BOMB:int =  1;
		public static var FOUR_WAY:int =  2;
		public static var SHOTGUN:int =  3;
		public static var STRAIGHTACROSS:int =  4;
		public static var BOMB_VERT:int =  5; // TODO these 2 are dupes in bg play area
		public static var AMMO_ROTATING:int =  6;  // TODO these 2 are dupes in bg play area
		public static var CLOUD:int = 7;
		
		public static const NOTHING:int = 0;
		public static const HOMING:int = 1;
		public static const DYING:int = 3;
		
		// TODO refactor eof
		
		public var lAction:int = 0;
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
			//trace("Do fire");
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
		
		protected function getNewBullet():Bullet {
			return new Bullet(game);
		}
		
		protected function getNextBullet():Bullet {
			var clip:Bullet = this.getNewBullet();
			//var clip:Bullet = theRoot.game.BGMid.bulletEnemy.duplicateMovieClip("bulletEnemy_" + ++Enemy.lBulletIndex, theRoot.game.BGMid.getNextHighestDepth());
			clip.x = this.x; // TODO offsetting?
			clip.y = this.y; // TODO offsetting?
			game.BGMid.addChild(clip);
			clip.addEventListener ( Event.ENTER_FRAME, clip.doFrame, false, 0, true);
			return clip;
		}
		
		protected function muzzleFlash():void {
			/*
			var flasher:MovieClip = game.BGMid.flasher0.duplicateMovieClip("bulletEnemy_" + +
	
	+Enemy.lBulletIndex, game.BGMid.getNextHighestDepth());
			
			flasher.x = this.x;
			flasher.y = this.y;
			*/
		}
		
		protected function loadHook():void {
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