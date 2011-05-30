class Turret extends Enemy {
	
	private var rateOfFire:Number = 30;
	private var clicksToFire:Number = 0;
	private var fireRange:Number = 600;
	private var scoreForKill:Number = 4;
	
	private var hp:Number = 3;
	
	// stub out methods that don't apply to turrets
	private function handleMovementY() {}
	private function handleMovementX() {}
	
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
	
	public function takeHit() {
		this["hitFlash"].gotoAndPlay(1);
		if(--this.hp <= 0) {
			_root.fcEnemies.kill(this);
		}
	}
}