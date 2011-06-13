import uk.co.gavd.enemies.Turret;
import uk.co.gavd.enemies.Enemy;

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
		
		_root.sfx.gotoAndPlay("enemyFireTurret" + this.fireType); // TODO bomber fire
		
		var bul:MovieClip = this.getNextBullet();
		this.targetBulletOnHero(bul);
		var bul1:MovieClip = this.getNextBullet();
		bul1.fire(_root.game.hero._x - _root.game.BGMid._x + 100,  _root.game.hero._y + 100);
		
		var bul2:MovieClip = this.getNextBullet();
		bul2.fire(_root.game.hero._x - _root.game.BGMid._x - 100,  _root.game.hero._y - 100);
		
		var bul3:MovieClip = this.getNextBullet();
		bul3.fire(_root.game.hero._x - _root.game.BGMid._x + 150,  _root.game.hero._y - 150);
		
		var bul4:MovieClip = this.getNextBullet();
		bul4.fire(_root.game.hero._x - _root.game.BGMid._x - 150,  _root.game.hero._y + 150);
		
		return false;
	}

}