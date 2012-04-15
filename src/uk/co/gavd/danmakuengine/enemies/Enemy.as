package uk.co.gavd.danmakuengine.enemies {
	import flash.filters.ColorMatrixFilter;
	import fl.motion.AdjustColor;
	import flash.display.MovieClip;
	import uk.co.gavd.danmakuengine.ballistics.*;
    import uk.co.gavd.danmakuengine.Game;
	import flash.events.Event;
	import flash.media.Sound;

    public class Enemy extends MovieClip {
		// TODO refactor sof
		protected var scoreForKill:int = 5;
		protected var fireRange:Number = 300;
		
		protected var hp:Number = 5;
		
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
		public static const DYING:int = 2;
		public static const DEAD:int = 3;
		// TODO refactor eof
		
		public var lAction:int = 0;
		public var bFacingLeft:Boolean = true;
		
		protected var game:Game;
		
		private var takeHitWav:Sound;
		
		// filter for flash on hit
		private var filterBW:Array;
		private var resetFilterCountdown:int = 0;
		
		public function Enemy(game:Game) {
			this.game = game;
			this.takeHitWav = new TakehitWav();
			this.loadFilter();
		}
		
		public function checkHit(bullet:Bullet):Boolean {
			return bullet.hitZone.hitTestObject(this);
		}
		
		private function loadFilter():void {
			var color : AdjustColor;
			var colorMatrix : ColorMatrixFilter;
			var matrix : Array;
			var filterBW : Array;
			 
			color = new AdjustColor();
			color.brightness = 100;
			color.contrast = 20;
			color.hue = 0;
			color.saturation = -100;
			 
			matrix = color.CalculateFinalFlatArray();
			colorMatrix = new ColorMatrixFilter(matrix);
			this.filterBW = [colorMatrix];
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
			
			if(resetFilterCountdown > 0) {
				if(--resetFilterCountdown == 0) {
					this.filters = [];
				}
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
				this.bFacingLeft = false;
				this.scaleX = -1;
			} else if (!this.bFacingLeft && targetX < this.x) {
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
			flasher.x = this.x;
			flasher.y = this.y;
			*/
		}
		
		protected function dieHook():void {
			
		}
		
		public function isOnScreen():Boolean {
			var foo:Number = (this.x - 580) * -1; // TODO 580 is a magic number
			if (game.BGMid.x < foo) { 
				return true;
			}
			
			return false;
		}
		
		public function takeHit():void {
			var theRootx:MovieClip = MovieClip(root); // TODO DI this?
			this.hp -= theRootx.game.hero.power;
			if(this.hp <= 0) {
				this.dieHook();
				theRootx.fcEnemies.kill(this);
			} else {
				this.filters = this.filterBW;
				this.resetFilterCountdown = 3;
				this.takeHitWav.play();
			}
		}
    }
}