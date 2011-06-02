import uk.co.gavd.Turret;
import uk.co.gavd.Enemy;

class uk.co.gavd.TurretScatter extends Turret {
	
	private var rateOfFire:Number = 140;
	private var clicksToFire:Number = 0;
	private var hp:Number = 15;
	private var scoreForKill:Number = 10;
	public static var SCATTER_FACTOR:Number = 150;
	
	private var fireType:Number = Enemy.SHOTGUN;
	
	private function doFire (lTargetX:Number, distFromHero:Number):Boolean {
		if(--this.clicksToFire <= 0) {
			this.clicksToFire = this.rateOfFire;
		} else {
			return false;
		}
		
		_root.sfx.gotoAndPlay("enemyFireTurret" + this.fireType); // TODO bomber fire
		
		var bul:MovieClip = this.getNextBullet(this._x, this._y + this.shotOffset, this.fireType);
		this.targetBulletOnHero(bul);
		var bul1:MovieClip = this.getNextBullet(this._x, this._y + this.shotOffset, this.fireType);
		bul1.lTargetX = bul.lTargetX + 100;
		bul1.lTargetY = bul.lTargetY + 100;
		
		var bul2:MovieClip = this.getNextBullet(this._x, this._y + this.shotOffset, this.fireType);
		bul2.lTargetX = bul.lTargetX - 100;
		bul2.lTargetY = bul.lTargetY - 100;
		
		var bul1:MovieClip = this.getNextBullet(this._x, this._y + this.shotOffset, this.fireType);
		bul1.lTargetX = bul.lTargetX + 150;
		bul1.lTargetY = bul.lTargetY - 150;
		
		var bul2:MovieClip = this.getNextBullet(this._x, this._y + this.shotOffset, this.fireType);
		bul2.lTargetX = bul.lTargetX - 150;
		bul2.lTargetY = bul.lTargetY + 150;
		
		return false;
	}

}