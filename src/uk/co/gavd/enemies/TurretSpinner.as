package uk.co.gavd.enemies {
	import uk.co.gavd.Game;
	import uk.co.gavd.ballistics.Bullet;
	import flash.display.*;
	import flash.events.Event;

    public class TurretSpinner extends Turret {
		
		public function TurretSpinner(game:Game) {
			super(game);
			
			this.fireRange = 300;
			this.rateOfFire = 5;
			this.scoreForKill = 5;
			this.hp = 20;
			
			this.addEventListener ( Event.ENTER_FRAME, this.doFrame);
		}
		
		private function doFrame(e:Event) {
			this.rotation++;
		}
		
		override protected function doFire (lTargetX:Number, distFromHero:Number):Boolean {
			//trace("FIRE BULLET AT TARGET");
			if(--this.clicksToFire <= 0) {
				this.clicksToFire = this.rateOfFire;
			} else {
				return false;
			}
			
	//		_root.sfx.gotoAndPlay("enemyFireTurret" + this.fireType); // TODO bomber fire
			
			var bul:Bullet = this.getNextBullet()
			// TODO rmove bul.addEventListener ( Event.ENTER_FRAME, bul.doFrame, false, 0, true);
			bul.fireAtAngle(this.rotation*-1 );
			
			return true;
		}
    }
}