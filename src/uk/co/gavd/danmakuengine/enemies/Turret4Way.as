package uk.co.gavd.enemies {
	import uk.co.gavd.Game;
	import uk.co.gavd.enemies.Turret;
	import uk.co.gavd.ballistics.Bullet;
	import flash.display.*;
	import flash.events.Event;

    public class Turret4Way extends Turret {
		
		public static var BARREL_LENGTH:int = 30;
		
		public function Turret4Way(game:Game) {
			super(game);
			
			this.fireRange = 400;
			this.scoreForKill = 20;
			this.hp = 20;
			this.rateOfFire = 200;
			
			this.fireSound = new FourWayWav();
		}
		
		override protected function doFire (lTargetX:Number, distFromHero:Number):Boolean {
		
            if(--this.clicksToFire <= 0) {
                this.clicksToFire = this.rateOfFire;
            } else {
                return false;
            }
			
			this.fireSound.play();
            
			var bul:Bullet = this.getNextBullet();
			bul.fireAtPoint(this.x, this.y - this.fireRange );
			bul.y += Turret4Way.BARREL_LENGTH;
			
			var bul2:Bullet = this.getNextBullet();
			bul2.fireAtPoint(this.x, this.y + this.fireRange );
			bul.y -= Turret4Way.BARREL_LENGTH;
			
			var bul3:Bullet = this.getNextBullet();
			bul3.fireAtPoint(this.x + this.fireRange, this.y );
			bul.x += Turret4Way.BARREL_LENGTH;
			
			var bul4:Bullet = this.getNextBullet();
			bul4.fireAtPoint(this.x - this.fireRange, this.y );
			bul.x -= Turret4Way.BARREL_LENGTH;
            
            return true;
        }

    }
}