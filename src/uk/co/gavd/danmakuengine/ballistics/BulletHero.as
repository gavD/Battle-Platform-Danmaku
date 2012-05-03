package uk.co.gavd.danmakuengine.ballistics {
    import flash.display.MovieClip;
    import uk.co.gavd.danmakuengine.Game;
    import flash.events.Event;
	
    public class BulletHero extends Bullet {

		protected var fireDistance:int = 900;
		
		public function BulletHero(game:Game) {
			super(game);
			
			this.lSpeed = 18;
			this.rotateToFace = true;
		}
		
        override protected function checkForHits():void {
			if(!this.isOnScreen()) {
				return;
			}
			var theRootx:MovieClip = MovieClip(root); // TODO DI this?
			theRootx.fcEnemies.detectHits(this);
        }
		
		
		protected function getOnScreenMin():uint {
			return 748;
		}
		
		// sOf copypasta from Enemy.as
		public function isOnScreen():Boolean {
			var fudgedNumber:Number = (this.x - this.getOnScreenMin()) * -1;
			if (game.BGMid.x < fudgedNumber) { 
				return true;
			}
			
			return false;
		}
		// eOf copypasta from Enemy.as
        
    }
}