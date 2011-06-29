﻿import uk.co.gavd.ballistics.Bullet;

class uk.co.gavd.enemies.Turret extends uk.co.gavd.enemies.Enemy {
	
	private var rateOfFire:Number = 44;
	private var clicksToFire:Number = 0;
	private var fireRange:Number = 600;
	private var scoreForKill:Number = 4;
	
	private var hp:Number = 5;
	
	// stub out methods that don't apply to turrets
	private function handleMovementY():Void {}
	private function handleMovementX():Void {}
	
	private function doFire (lTargetX:Number, distFromHero:Number):Boolean {
		if(--this.clicksToFire <= 0) {
			this.clicksToFire = this.rateOfFire;
		} else {
			return false;
		}
		
//		_root.sfx.gotoAndPlay("enemyFireTurret" + this.fireType); // TODO bomber fire
		
		this.getNextBullet().fireAtTarget(_root.game.hero);
		
		return true;
	}
	
	public function takeHit():Void {
		this.hp -= _root.game.hero.power;
		if(this.hp <= 0) {
			_root.fcEnemies.kill(this);
		} else {
			this["hitFlash"].gotoAndPlay(1);
			_root.sfxEnemyExplosions.gotoAndPlay("hit");
		}
	}
}