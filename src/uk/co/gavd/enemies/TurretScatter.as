import uk.co.gavd.enemies.Turret;
import uk.co.gavd.enemies.Enemy;
import uk.co.gavd.ballistics.Bullet;

class uk.co.gavd.enemies.TurretScatter extends Turret {
	
	private var rateOfFire:Number = 140;
	private var clicksToFire:Number = 0;
	private var hp:Number = 15;
	private var scoreForKill:Number = 10;
	public static var SCATTER_FACTOR:Number = 150;
	
	private function doFire (lTargetX:Number, distFromHero:Number):Boolean {
		if(--this.clicksToFire <= 0) {
			this.clicksToFire = this.rateOfFire;
		} else {
			return false;
		}
		
//		_root.sfx.gotoAndPlay("enemyFireTurret" + this.fireType); // TODO bomber fire
		
		var bul:Bullet = this.getNextBullet();
		bul.fireAtTarget(_root.game.hero);
		
		var bul1:Bullet = this.getNextBullet();
		bul1.fireAtPoint(bul.targetX + 100,  bul.targetY + 100);
		
		var bul2:Bullet = this.getNextBullet();
		bul2.fireAtPoint(bul.targetX - 100,  bul.targetY - 100);
		
		var bul3:Bullet = this.getNextBullet();
		bul3.fireAtPoint(bul.targetX - 150,  bul.targetY - 150);
		
		var bul4:Bullet = this.getNextBullet();
		bul4.fireAtPoint(bul.targetX + 150,  bul.targetY + 150);
		
		return false;
	}

}