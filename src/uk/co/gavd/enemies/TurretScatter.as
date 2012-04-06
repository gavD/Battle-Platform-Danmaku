package uk.co.gavd.enemies {
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
			this.hp = 10;
		}
    
		override protected function doFire (lTargetX:Number, distFromHero:Number):Boolean {
			if(--this.clicksToFire <= 0) {
				this.clicksToFire = this.rateOfFire;
			} else {
				return false;
			}
			
	//        theRoot.sfx.gotoAndPlay("enemyFireTurret" + this.fireType); // TODO bomber fire
			
			this.getNextBullet().fireAtAngle(-90);
			this.getNextBullet().fireAtAngle(-110);
			this.getNextBullet().fireAtAngle(-135);
			this.getNextBullet().fireAtAngle(-160);
			this.getNextBullet().fireAtAngle(-180);
			
			/*
			var bul1:Bullet = this.getNextBullet();
			
			bul1.fireAtPoint(bul.targetX + 100,  bul.targetY + 100);
			
			var bul2:Bullet = this.getNextBullet();
			bul2.fireAtPoint(bul.targetX - 100,  bul.targetY - 100);
			
			var bul3:Bullet = this.getNextBullet();
			bul3.fireAtPoint(bul.targetX - 150,  bul.targetY - 150);
			
			var bul4:Bullet = this.getNextBullet();
			bul4.fireAtPoint(bul.targetX + 150,  bul.targetY + 150);
			*/
			return false;
		}
		
		override protected function getNewBullet():Bullet {
			return new BulletSlow(game);
		}
    }
}