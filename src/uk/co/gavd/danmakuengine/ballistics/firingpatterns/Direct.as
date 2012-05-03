package uk.co.gavd.danmakuengine.ballistics.firingpatterns 
{
	import uk.co.gavd.danmakuengine.ballistics.BulletFast;
	import uk.co.gavd.danmakuengine.enemies.Enemy;
	
	/**
	 * ...
	 * @author Gavin Davies
	 */
	public class Direct extends FiringPattern
	{	
		public function process():void {
			var clip:Bullet = new BulletFast(game);
			clip.x = this.enemy.x;
			clip.y = this.enemy.y;
			game.BGMid.addChild(clip);
			clip.fireAtTarget(game.hero);
		}
	}

}