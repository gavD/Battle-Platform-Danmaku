package uk.co.gavd.ballistics {
    import flash.display.*
    import uk.co.gavd.Game;
	
    public class BulletHero extends Bullet {

		private var fireDistance:int = 800;
		
		public function BulletHero(game:Game) {
			super(game);
		}
		
		public function targetOn(targetX:Number, targetY:Number):void {
            trace("TODO where called from?");
            var myRadians:Number = Math.atan2(this.y - targetY, targetX - this.x);
            myRadians += Math.PI/2; // rotate round 90' - needs that for some reason
            this.targetX = this.x + Math.sin(myRadians) * fireDistance;
            this.targetY = this.y + Math.cos(myRadians) * fireDistance;
        }
		
        override protected function checkForHits():void {
//			trace("Check for hits");
			var theRootx:MovieClip = MovieClip(root); // TODO DI this?
//			trace(" # " + theRootx);
//			trace(" ## " + theRootx.fcEnemies);
			
			theRootx.fcEnemies.detectHits(this);

        }
    }
}