class Turret4Way extends Turret {
	
	private var hp:Number = 7;
	private var scoreForKill:Number = 7;
	
	private function doFire (lTargetX:Number, distFromHero:Number):Boolean {
		if(--this.clicksToFire <= 0) {
			this.clicksToFire = this.rateOfFire;
		} else {
			return false;
		}
		_root.sfx.gotoAndPlay("enemyFireTurret" + this.fireType); // TODO bomber fire
		
		var mcTmp:MovieClip = this.getNextBullet(this._x, this._y, this.fireType);
		_root.fcBullets.targetObjectOnPoint(mcTmp, this._x, this._y - 200 );
		mcTmp = this.getNextBullet(this._x, this._y, this.fireType);
		_root.fcBullets.targetObjectOnPoint(mcTmp, this._x, this._y + 200 );
		mcTmp = this.getNextBullet(this._x, this._y, this.fireType);
		_root.fcBullets.targetObjectOnPoint(mcTmp, this._x - 200, this._y );
		mcTmp = this.getNextBullet(this._x, this._y, this.fireType);
		_root.fcBullets.targetObjectOnPoint(mcTmp, this._x + 200, this._y );
		
		return true;
	}	
}