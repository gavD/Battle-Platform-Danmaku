class Turret extends Enemy {
	
	private var rateOfFire:Number = 30;
	private var clicksToFire:Number = 0;
	private var fireRange:Number = 600;
	private var scoreForKill:Number = 4;
	
	private var hp:Number = 4;
	
	// stub out methods that don't apply to turrets
	private function handleMovementY():Void {}
	private function handleMovementX():Void {}
	
	private function doFire (lTargetX:Number, distFromHero:Number):Boolean {
		if(--this.clicksToFire <= 0) {
			this.clicksToFire = this.rateOfFire;
		} else {
			return false;
		}
		
		_root.sfx.gotoAndPlay("enemyFireTurret" + this.fireType); // TODO bomber fire
		
		var mcTmp:MovieClip = this.getNextBullet(this._x, this._y, this.fireType);
		this.targetBulletOnHero(mcTmp);
		
		return true;
	}
	
	public function takeHit():Void {
		if(--this.hp <= 0) {
			_root.fcEnemies.kill(this);
		} else {
			this["hitFlash"].gotoAndPlay(1);
			_root.sfxEnemyExplosions.gotoAndPlay("hit");
		}
	}
}