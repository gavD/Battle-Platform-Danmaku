import uk.co.gavd.ballistics.Bullet;

class uk.co.gavd.ballistics.BulletHero extends Bullet {
	private var lSpeed:Number = 30;
	private var fireDistance:Number = 800;
	
	private function checkForHits():Void {
		_root.fcEnemies.detectHits(this);
	}
	
	private function targetOn(targetX:Number, targetY:Number) {
		var myRadians:Number = Math.atan2(this._y - targetY, targetX - this._x);
		myRadians += Math.PI/2; // rotate round 90' - needs that for some reason
		this.targetX = this._x + Math.sin(myRadians) * fireDistance;
		this.targetY = this._y + Math.cos(myRadians) * fireDistance;
	}
}