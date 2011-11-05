package uk.co.gavd {
    import flash.display.*;
    import flash.events.*;
	import uk.co.gavd.ballistics.*;
    
    public class Reticle extends MovieClip {
        private var lShotIndex:Number = 0;
        private var lMuzzleIndex:Number = 0;
        private var isMouseDown:Boolean = false;
        private var framesBetweenShots:Number = 7;
        private var clicksToNextShot:Number = 0;
        
		private var game:Game;
		
		public function Reticle(game:Game) {
			this.game = game;
		}
        
        public function fireShot(directional:Boolean):void {
            //if (bGamePaused) {
              //  trace("GAME PAUSED - CAN'T FIRE");
                //return;
            //} else // TODO
			if (game.hero.lAction != game.hero.OK) {
                trace("HERO NOT OK - CAN'T FIRE");
                return;
            }
            
            // fire a bullet
            lShotIndex++;
			
			var b:BulletHero = new BulletHero(game);
			
            b.x = game.hero.x - game.BGMid.x + 55;
            b.y = game.hero.y + 12;
			game.BGMid.addChild(b);    
            if(directional) {
                var virtualCursorX:Number = this.x - game.x - game.BGMid.x;
                b.fireAtPoint(virtualCursorX, this.y);
                var myRadians:Number = Math.atan2( b.y - b.targetY, b.x - b.targetX );
                b.rotation = (myRadians * (180 / Math.PI)) + 180;
            } else { // straight line fire
                b.fireAtPoint(b.x + 750, b.y);
            }
			
            b.addEventListener(Event.ENTER_FRAME, b.doFrame, false, 0, true);
			
    /*
            var muzzle:MovieClip = game.BGMid.muzzleHero.duplicateMovieClip("muzzleHero" + lMuzzleIndex, game.BGMid.getNextHighestDepth());
            //eval("game.BGMid.muzzleHero" + lMuzzleIndex++);
            muzzle.x = b.x;
            muzzle.y = b.y;
            if(!game.hero.facingRight) {
                muzzle.rotation = 180;
            }
            muzzle.gotoAndPlay(2);
*/
        }
        
        public function doMouseDown(event:MouseEvent):void {
            this.isMouseDown = true;
            trace("MOUSE DOWN");
        }
        public function doMouseUp(event:MouseEvent):void {
            trace("MOUSE UP");
            this.clicksToNextShot = 0;
            this.isMouseDown = false;
        }
        
        public function doFrame(e:Event):void {
			/*
			trace("e " + e.toString());
            this.x = mouseX;
            this.y = mouseY;
            */
            if(this.isMouseDown) {
                if(--this.clicksToNextShot <= 0) {
                    this.fireShot(true);
                    this.clicksToNextShot = this.framesBetweenShots;
                }
            }
        }
    }
}