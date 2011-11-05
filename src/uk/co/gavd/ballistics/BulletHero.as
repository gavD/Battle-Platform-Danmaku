package uk.co.gavd.ballistics {
    import flash.display.*
	
    public class BulletHero extends Bullet {

		private var fireDistance:int = 800;
		
		public function BulletHero() {
			this.lSpeed = 30;
			this.stop();
		}
		
		public function targetOn(targetX:Number, targetY:Number):void {
            trace("TODO where called from?");
            var myRadians:Number = Math.atan2(this.y - targetY, targetX - this.x);
            myRadians += Math.PI/2; // rotate round 90' - needs that for some reason
            this.targetX = this.x + Math.sin(myRadians) * fireDistance;
            this.targetY = this.y + Math.cos(myRadians) * fireDistance;
        }
		
        override protected function checkForHits():void {
// TODO            theRoot.fcEnemies.detectHits(this);
        }
    }
}