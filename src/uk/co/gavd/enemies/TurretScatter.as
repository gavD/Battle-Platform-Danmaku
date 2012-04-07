﻿package uk.co.gavd.enemies {
	import uk.co.gavd.Game;
	import uk.co.gavd.enemies.Turret;
	import uk.co.gavd.ballistics.Bullet;
	import uk.co.gavd.ballistics.BulletSlow;
	import flash.events.Event;

    public class TurretScatter extends Turret  {
    
		public function TurretScatter(game:Game) {
			super(game);
			
			this.fireRange = 600;
			this.rateOfFire = 110;
			this.scoreForKill = 10;
			this.hp = 11;
			
			this.fireSound = new ShotgunWav();
		}
    
		override protected function doFire (lTargetX:Number, distFromHero:Number):Boolean {
			if(--this.clicksToFire <= 0) {
				this.clicksToFire = this.rateOfFire;
			} else {
				return false;
			}
			
			this.fireSound.play();
			
			this.getNextBullet().fireAtAngle(-90);
			this.getNextBullet().fireAtAngle(-110);
			this.getNextBullet().fireAtAngle(-135);
			this.getNextBullet().fireAtAngle(-160);
			this.getNextBullet().fireAtAngle(-180);
			
			return false; // TODO why?sd
		}
		
		override protected function getNewBullet():Bullet {
			return new BulletSlow(game);
		}
    }
}