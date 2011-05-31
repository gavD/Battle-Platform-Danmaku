class TurretScatter extends Turret {
	
	private var rateOfFire:Number = 140;
	private var clicksToFire:Number = 0;
	private var hp:Number = 15;
	private var scoreForKill:Number = 10;
	public static var SHOTGUN_PELLETS:Number = 5;
	public static var SCATTER_FACTOR:Number = 120;
	
	private var fireType:Number = Enemy.SHOTGUN;
	
	private function doFire (lTargetX:Number, distFromHero:Number):Boolean {
		if(--this.clicksToFire <= 0) {
			this.clicksToFire = this.rateOfFire;
		} else {
			return false;
		}
		
		_root.sfx.gotoAndPlay("enemyFireTurret" + this.fireType); // TODO bomber fire
		
		for (var i = 0; i < TurretScatter.SHOTGUN_PELLETS; i++) {
			var bul:MovieClip = this.getNextBullet(this._x, this._y + this.shotOffset, this.fireType);
			this.targetBulletOnHeroWithOffset(bul, (i - 2) * SCATTER_FACTOR);
		}
		
		return true;
	}

	private function targetBulletOnHeroWithOffset (mcTmp:MovieClip, offset:Number):Void {
		_root.fcBullets.targetObjectOnPoint(
			mcTmp,
			_root.game.hero._x - _root.game.BGMid._x + offset,
			_root.game.hero._y + offset
		);
	}	
}