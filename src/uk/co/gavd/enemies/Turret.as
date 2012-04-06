package uk.co.gavd.enemies {
	import uk.co.gavd.Game;
	import uk.co.gavd.ballistics.Bullet;
	import flash.display.*;
	import flash.events.Event;

    public class Turret extends Enemy {
		
		protected var rateOfFire:int = 44;
		protected var clicksToFire:int = 0;
		
		public function Turret(game:Game) {
			this.fireRange = 600;
			this.scoreForKill = 4;
			super(game);
		}
		
		// stub out methods that don't apply to turrets
		override protected function handleMovementY():void {}
		override protected function handleMovementX():void {}
		
		override protected function doFire (lTargetX:Number, distFromHero:Number):Boolean {
			//trace("FIRE BULLET AT TARGET");
			if(--this.clicksToFire <= 0) {
				this.clicksToFire = this.rateOfFire;
			} else {
				return false;
			}
			
	//		_root.sfx.gotoAndPlay("enemyFireTurret" + this.fireType); // TODO bomber fire
			
			var bul:Bullet = this.getNextBullet()
			bul.addEventListener ( Event.ENTER_FRAME, bul.doFrame, false, 0, true);
			bul.fireAtTarget(game.hero);
			
			return true;
		}
		
		public function takeHit():void {
			var theRootx:MovieClip = MovieClip(root); // TODO DI this?
			trace("HIT! hp is " + this.hp + " ; decrement by " + theRootx.game.hero.power);
			this.hp -= theRootx.game.hero.power;
			if(this.hp <= 0) {
				theRootx.fcEnemies.kill(this);
			} else {
				//this["hitFlash"].gotoAndPlay(1);
				theRootx.sfxEnemyExplosions.gotoAndPlay("hit");
			}
		}
    }
}