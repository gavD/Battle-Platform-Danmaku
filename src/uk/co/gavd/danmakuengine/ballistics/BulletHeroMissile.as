package uk.co.gavd.danmakuengine.ballistics {
	import flash.display.MovieClip;
	import uk.co.gavd.danmakuengine.Game;
	
    public class BulletHeroMissile extends BulletMissile {
		public function BulletHeroMissile(game:Game) {
			super(game);
			
			this.damage = 30;
			this.turn = 2.3;
			this.lSpeed = 4;
		}
		
		override protected function checkForHits():void {
			var theRootx:MovieClip = MovieClip(root); // TODO DI this?
			theRootx.fcEnemies.detectHits(this);
			//trace(this + " frames to live=" + this.framesToLive);
        }
    }
}