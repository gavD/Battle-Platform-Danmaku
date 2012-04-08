package uk.co.gavd.enemies {
	import flash.display.MovieClip;
	import uk.co.gavd.ballistics.*;
    import uk.co.gavd.Game;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.media.Sound;

    public class Enemy extends MovieClip {
	    private static var lBulletIndex:Number = 0; // TODO move to bullets?
		
		public var flasher:MovieClip;

		// TODO refactor sof
		protected var prefDistToHero:Number = 120;
		protected var shotOffset:Number = 0; // adjust where the bullet spawns from
		protected var scoreForKill:int = 5;
		protected var fireRange:Number = 300;
		
		protected var hp:Number = 5;
		protected var prefYFromHero:Number = 20; // how far a clip should try to get in line with the hero
		
		// ammo types
		public static const AIMATHERO:int =  0;
		public static const BOMB:int =  1;
		public static const FOUR_WAY:int =  2;
		public static const SHOTGUN:int =  3;
		public static const STRAIGHTACROSS:int =  4;
		public static const BOMB_VERT:int =  5; // TODO these 2 are dupes in bg play area
		public static const AMMO_ROTATING:int =  6;  // TODO these 2 are dupes in bg play area
		public static const CLOUD:int = 7;
		
		public static const NOTHING:int = 0;
		public static const HOMING:int = 1;
		public static const DYING:int = 3;
		
		// TODO refactor eof
		
		public var lAction:int = 0;
		public var bFacingLeft:Boolean = true;
		
		protected var game:Game;
		
		private var takeHitWav:Sound;
		
		public function Enemy(game:Game) {
			this.game = game;
			this.takeHitWav = new TakehitWav();
		}

		public function process():void {
			
			if (game.hero.lAction != 0) {
				//trace("game not in play");
				return;
			}

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
			this.handleMovementX();
			this.handleMovementY();
			
			var targetX:Number = game.hero.x - game.BGMid.x;
			
			this.turnAndFace(targetX);
			this.handleFiring(targetX);
		}
		
		protected function handleMovementX():void {}
		protected function handleMovementY():void {}
		
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
			if (lDistX <= this.fireRange) { // within firing range
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
			clip.x = this.x;
			clip.y = this.y;
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
		
		public function takeHit():void {
			trace("PLAY FLASHER");
			
			var theRootx:MovieClip = MovieClip(root); // TODO DI this?
			this.hp -= theRootx.game.hero.power;
			if(this.hp <= 0) {
				theRootx.fcEnemies.kill(this);
			} else {
				flasher.gotoAndPlay(1);
				this.takeHitWav.play();
				//var filter = new flash.filters.ColorMatrixFilter; 
				//var myTempFilters:Array = this.filters; 
				//myTempFilters.push(filter);
				//this.filters = myTempFilters;s
			}
		}
    }
}