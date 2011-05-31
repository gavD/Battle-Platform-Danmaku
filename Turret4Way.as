class Turret4Way extends Turret {
	
	private var hp:Number = 17;
	private var scoreForKill:Number = 20;
	private var rateOfFire:Number = 110;
	
	private static var FIRE_DISTANCE:Number = 500;
	private var fireType:Number = Enemy.FOUR_WAY;
	
	private function doFire (lTargetX:Number, distFromHero:Number):Boolean {
		if(--this.clicksToFire <= 0) {
			this.clicksToFire = this.rateOfFire;
		} else {
			return false;
		}
		_root.sfx.gotoAndPlay("enemyFireTurret" + this.fireType); // TODO bomber fire
		
		var mcTmp:MovieClip = this.getNextBullet(this._x, this._y, this.fireType);
		_root.fcBullets.targetObjectOnPoint(mcTmp, this._x, this._y - FIRE_DISTANCE );
		mcTmp = this.getNextBullet(this._x, this._y, this.fireType);
		_root.fcBullets.targetObjectOnPoint(mcTmp, this._x, this._y + FIRE_DISTANCE  );
		mcTmp = this.getNextBullet(this._x, this._y, this.fireType);
		_root.fcBullets.targetObjectOnPoint(mcTmp, this._x - FIRE_DISTANCE , this._y );
		mcTmp = this.getNextBullet(this._x, this._y, this.fireType);
		_root.fcBullets.targetObjectOnPoint(mcTmp, this._x + FIRE_DISTANCE , this._y );
		
		return true;
	}	
}