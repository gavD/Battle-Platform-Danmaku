import uk.co.gavd.enemies.Turret;
import uk.co.gavd.enemies.Enemy;
import uk.co.gavd.ballistics.Bullet;

class uk.co.gavd.enemies.TurretSpinner extends Turret {
	
	private var hp:Number = 10;
	private var scoreForKill:Number = 30;
	private var rateOfFire:Number = 5;
	
	private static var FIRE_DISTANCE:Number = 400;
	
	private function doFire (lTargetX:Number, distFromHero:Number):Boolean {
		if(--this.clicksToFire <= 0) {
			this.clicksToFire = this.rateOfFire;
		} else {
			return false;
		}
		//_root.sfx.gotoAndPlay("enemyFireTurret" + this.fireType); // TODO bomber fire
		
		this.getNextBullet().fireAtAngle(this._rotation*-1 );
		//this.getNextBullet().fireAtAngle(this._rotation );
		
		return true;
	}	
	
	private function getNextBullet():Bullet {
		var clip:Bullet = _root.game.BGMid.bulletEnemySlow.duplicateMovieClip("bulletEnemy_" + ++Enemy.lBulletIndex, _root.game.BGMid.getNextHighestDepth());
		clip._x = this._x; // TODO offsetting?
		clip._y = this._y; // TODO offsetting?
		return clip;
	}
	
	public function onEnterFrame():Void {
		this._rotation++;
	}
}