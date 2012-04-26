package uk.co.gavd.danmakuengine.enemies {
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.ballistics.Bullet;
	import uk.co.gavd.danmakuengine.ballistics.BulletSlow;
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
    
		override protected function doFire (lTargetX:Number, distFromHero:Number):void {
			if(--this.clicksToFire <= 0) {
				this.clicksToFire = this.rateOfFire;
			} else {
				return;
			}
			
			this.fireSound.play();
			
			this.getNextBullet().fireAtAngle(-90);
			this.getNextBullet().fireAtAngle(-110);
			this.getNextBullet().fireAtAngle(-135);
			this.getNextBullet().fireAtAngle(-160);
			this.getNextBullet().fireAtAngle(-180);
			
			return; // TODO why?
		}
		
		override protected function getNewBullet():Bullet {
			return new BulletSlow(game);
		}
    }
}