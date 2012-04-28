package uk.co.gavd.danmakuengine.enemies {
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.ballistics.Bullet;
	import uk.co.gavd.danmakuengine.ballistics.BulletSlow;
	import flash.events.Event;

    public class TurretScatter extends Turret  {
    
		public function TurretScatter() {
			super();
			
			this.fireRange = 600;
			this.rateOfFire = 110;
			this.scoreForKill = 10;
			this.hp = 11;
			
			this.fireSound = new ShotgunWav();
		}
    
		override protected function doFire (lTargetX:Number, distFromHero:Number):void {
			if(--this.clicksToFire <= 0) {
				this.clicksToFire = this.rateOfFire;
			} else {
				return;
			}
			
			this.fireSound.play();
			
			if(this.facingLeft) {
				this.getNextBullet().fireAtAngleRadians(3.4, true);
				this.getNextBullet().fireAtAngleRadians(3.6, true);
				this.getNextBullet().fireAtAngleRadians(3.8, true);
				this.getNextBullet().fireAtAngleRadians(4, true);
			} else {
				
				this.getNextBullet().fireAtAngleRadians(2.0, true);
				this.getNextBullet().fireAtAngleRadians(2.2, true);
				this.getNextBullet().fireAtAngleRadians(2.4, true);
				this.getNextBullet().fireAtAngleRadians(2.6, true);
				
			}
		}
    }
}