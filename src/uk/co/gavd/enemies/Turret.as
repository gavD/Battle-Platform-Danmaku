package uk.co.gavd.enemies {
	import uk.co.gavd.ballistics.Bullet;
	import flash.display.*;

    public class Turret extends Enemy {
		
		private var rateOfFire:Number = 44;
		private var clicksToFire:Number = 0;
		private var fireRange:Number = 600;
		private var scoreForKill:Number = 4;
		
		private var hp:Number = 5;
		
		// stub out methods that don't apply to turrets
		private function handleMovementY():void {}
		private function handleMovementX():void {}
		
			protected var theRoot:MovieClip = MovieClip(root); // todo - factor out?
			protected var hitFlash:MovieClip;
		private function doFire (lTargetX:Number, distFromHero:Number):Boolean {
			if(--this.clicksToFire <= 0) {
				this.clicksToFire = this.rateOfFire;
			} else {
				return false;
			}
			
	//        theRoot.sfx.gotoAndPlay("enemyFireTurret" + this.fireType); // TODO bomber fire
			
			// TODO this.getNextBullet().fireAtTarget(theRoot.game.hero);
			
			return true;
		}
		
		public function takeHit():void {
			this.hp -= theRoot.game.hero.power;
			if(this.hp <= 0) {
				theRoot.fcEnemies.kill(this);
			} else {
				//this["hitFlash"].gotoAndPlay(1);
				theRoot.sfxEnemyExplosions.gotoAndPlay("hit");
			}
		}
    }
}