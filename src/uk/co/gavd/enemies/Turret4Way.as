import uk.co.gavd.enemies.Turret;
import uk.co.gavd.enemies.Enemy;

class uk.co.gavd.enemies.Turret4Way extends Turret {
	
	private var hp:Number = 17;
	private var scoreForKill:Number = 20;
	private var rateOfFire:Number = 110;
	
	private static var FIRE_DISTANCE:Number = 500;
	
	private function doFire (lTargetX:Number, distFromHero:Number):Boolean {
		if(--this.clicksToFire <= 0) {
			this.clicksToFire = this.rateOfFire;
		} else {
			return false;
		}
		//_root.sfx.gotoAndPlay("enemyFireTurret" + this.fireType); // TODO bomber fire
		
		this.getNextBullet().fireAtPoint(this._x, this._y - FIRE_DISTANCE );
		this.getNextBullet().fireAtPoint(this._x, this._y + FIRE_DISTANCE );
		this.getNextBullet().fireAtPoint(this._x + FIRE_DISTANCE, this._y );
		this.getNextBullet().fireAtPoint(this._x - FIRE_DISTANCE, this._y );
		
		return true;
	}	
}