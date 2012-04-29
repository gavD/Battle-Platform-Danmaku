package uk.co.gavd.danmakuengine.enemies
{
	import flash.display.MovieClip;
	import uk.co.gavd.danmakuengine.ballistics.*;
	import uk.co.gavd.danmakuengine.Game;
	import flash.events.Event;
	import uk.co.gavd.danmakuengine.HitTaker;
	import uk.co.gavd.danmakuengine.hud.ScoreFloater;
	
	public class Enemy extends MovieClip
	{
		protected var scoreForKill:uint = 5;
		protected var fireRange:Number = 300;
		
		protected var hp:Number = 5;
		
		public static const NOTHING:uint = 0;
		public static const NORMAL:uint = 1;
		public static const DYING:uint = 2;
		public static const DEAD:uint = 3;
		// TODO refactor eof
		
		public var lAction:uint = 0;
		public var facingLeft:Boolean = true;
		
		protected var game:Game;
		
		private var hitTaker:HitTaker;
		
		public function Enemy()
		{
			this.hitTaker = new HitTaker(this);
		}
		
			
		public function setGame(game:Game):void {
			this.game = game;
		}
		
		public function checkHit(bullet:Bullet):Boolean
		{
			return bullet.hitArea.hitTestObject(this);
		}
		
		public function process():void
		{
			hitTaker.onFrame();
			
			if (!this.isOnScreen())
			{
				return;
			}
			
			if (game.hero.lAction != 0)
			{
				return;
			}
			
			if (this.lAction == Enemy.DYING)
			{
				return;
			}
			
			this.handleMovementAndShooting();
		}
		
		private function handleMovementAndShooting():void
		{
			this.handleMovementX();
			this.handleMovementY();
			
			var targetX:Number = game.hero.x - game.BGMid.x;
			
			this.turnAndFace(targetX);
			this.handleFiring(targetX);
		}
		
		protected function handleMovementX():void
		{
		}
		
		protected function handleMovementY():void
		{
		}
		
		protected function turnAndFace(targetX:Number):void
		{
			if (this.facingLeft && targetX > this.x)
			{
				this.facingLeft = false;
				this.scaleX = -1;
			}
			else if (!this.facingLeft && targetX < this.x)
			{
				this.facingLeft = true;
				this.scaleX = 1;
			}
		}
		
		private function handleFiring(targetX:Number):void
		{
			var distFromHero:Number = targetX - this.x;
			var lDistX:Number = Math.abs(distFromHero);
			if (lDistX <= this.fireRange)
			{ // within firing range
				if (this.doFire(targetX, distFromHero))
				{
					this.muzzleFlash();
				}
			}
		}
		
		protected function doFire(targetX:Number, distFromHero:Number):void
		{
		}
		
		protected function getNewBullet():Bullet
		{
			return new BulletLong20pxPink(game);
		}
		
		protected function getNextBullet():Bullet
		{
			var clip:Bullet = this.getNewBullet();
			clip.x = this.x;
			clip.y = this.y;
			game.BGMid.addChild(clip);
			return clip;
		}
		
		protected function muzzleFlash():void
		{
			// TODO
		}
		
		protected function dieHook():void
		{
		
		}
		
		protected function getOnScreenMin():uint
		{
			return 777;
		}
		
		public function isOnScreen():Boolean
		{
			var fudgedNumber:Number = (this.x - this.getOnScreenMin()) * -1;
			if (game.BGMid.x < fudgedNumber)
			{
				return true;
			}
			
			return false;
		}
		
		public function takeHit():void
		{
			var theRootx:MovieClip = MovieClip(root); // TODO DI this?
			this.hp -= theRootx.game.hero.power;
			if (this.hp <= 0)
			{
				var score:uint = this.scoreForKill + (this.scoreForKill * theRootx.comboBar.getCombo());
				trace(this + "SCORE IS " + score);
				var sf:ScoreFloater = new ScoreFloater(score);
				sf.x = this.x;
				sf.y = this.y;
				this.game.BGMid.addChild(sf);
				
				theRootx.comboBar.comboUp();
				theRootx.scoreDisplay.scoreUp(score);
				
				this.dieHook();
				theRootx.fcEnemies.kill(this);
			}
			else
			{
				this.hitTaker.takeHit(10);
			}
		}
	}
}