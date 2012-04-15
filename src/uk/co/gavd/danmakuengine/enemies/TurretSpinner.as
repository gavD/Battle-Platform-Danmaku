package uk.co.gavd.danmakuengine.enemies {
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.ballistics.Bullet;
	import flash.display.*;
	import flash.events.Event;

    public class TurretSpinner extends Turret {
		
		public function TurretSpinner(game:Game) {
			super(game);
			
			this.fireRange = 300;
			this.rateOfFire = 14;
			this.scoreForKill = 5;
			this.hp = 25;
			
			this.addEventListener ( Event.ENTER_FRAME, this.doFrame, false, 0, true);
		}
		
		private function doFrame(e:Event):void {
			this.rotation++;
		}
		
		override protected function doFire (lTargetX:Number, distFromHero:Number):Boolean {
			if(--this.clicksToFire <= 0) {
				this.clicksToFire = this.rateOfFire;
			} else {
				return false;
			}
			
			this.fireSound.play();
			
			var bul:Bullet = this.getNextBullet()
			bul.fireAtAngle(this.rotation*-1 );
			
			return true;
		}
    }
}