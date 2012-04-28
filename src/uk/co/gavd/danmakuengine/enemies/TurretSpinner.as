package uk.co.gavd.danmakuengine.enemies {
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.ballistics.Bullet;
	import flash.events.Event;

    public class TurretSpinner extends Turret {
		
		public function TurretSpinner() {
			super();
			
			this.fireRange = 300;
			this.rateOfFire = 14;
			this.scoreForKill = 20;
			this.hp = 25;
			
			this.addEventListener ( Event.ENTER_FRAME, this.onFrame, false, 0, true);
		}
		
		private function onFrame(e:Event):void {
			this.rotation++;
		}
		
		override protected function doFire (lTargetX:Number, distFromHero:Number):void {
			if(--this.clicksToFire <= 0) {
				this.clicksToFire = this.rateOfFire;
			} else {
				return;
			}
			
			this.fireSound.play();
			
			this.getNextBullet().fireAtAngle(this.rotation*-1, true);
			
			return;
		}
    }
}