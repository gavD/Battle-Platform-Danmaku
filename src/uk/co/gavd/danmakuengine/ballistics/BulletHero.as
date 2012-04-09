package uk.co.gavd.danmakuengine.ballistics {
    import flash.display.MovieClip;
    import uk.co.gavd.danmakuengine.Game;
	
    public class BulletHero extends Bullet {

		protected var fireDistance:int = 800;
		
		public function BulletHero(game:Game) {
			super(game);
			
			this.lSpeed = 22;
		}
		
		public function targetOn(targetX:Number, targetY:Number):void {
            trace("TODO where called from?");
            var myRadians:Number = Math.atan2(this.y - targetY, targetX - this.x);
            myRadians += Math.PI/2; // rotate round 90' - needs that for some reason
            this.targetX = this.x + Math.sin(myRadians) * fireDistance;
            this.targetY = this.y + Math.cos(myRadians) * fireDistance;
        }
		
        override protected function checkForHits():void {
			if(this.triggered) {
				trace("#### TRIGGERED ### bail");
				return;
			}
			var theRootx:MovieClip = MovieClip(root); // TODO DI this?
			
			theRootx.fcEnemies.detectHits(this);

        }
    }
}