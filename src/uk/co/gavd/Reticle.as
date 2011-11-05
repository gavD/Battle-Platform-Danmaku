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
        
        protected var theRoot:MovieClip = MovieClip(root);
        
        public function fireShot(directional:Boolean):void {
            if (theRoot.bGamePaused) {
                trace("GAME PAUSED - CAN'T FIRE");
                return;
            } else if (theRoot.game.hero.lAction != theRoot.game.hero.OK) {
                trace("HERO NOT OK - CAN'T FIRE");
                return;
            }
            
            // fire a bullet
            lShotIndex++;
			
			var b:BulletHero = new BulletHero();
			
            b.x = theRoot.game.hero.x - theRoot.game.BGMid.x + 55;
            b.y = theRoot.game.hero.y + 12;
			theRoot.game.BGMid.addChild(b);    
            if(theRoot.ANGLED_SHOTS && directional) {
                var virtualCursorX:Number = this.x - theRoot.game.x - theRoot.game.BGMid.x;
                b.fireAtPoint(virtualCursorX, this.y);
                var myRadians:Number = Math.atan2( b.y - b.targetY, b.x - b.targetX );
                b.rotation = (myRadians * (180 / Math.PI)) + 180;
            } else { // straight line fire
                b.fireAtPoint(b.x + 750 * (theRoot.game.hero.facingRight ? 1 : -1), b.y);
                if(!theRoot.game.hero.facingRight) {
                    b.rotation = 180;
                }
            }
			
            b.addEventListener(Event.ENTER_FRAME, b.doFrame, false, 0, true);
			
    /*
            var muzzle:MovieClip = theRoot.game.BGMid.muzzleHero.duplicateMovieClip("muzzleHero" + lMuzzleIndex, theRoot.game.BGMid.getNextHighestDepth());
            //eval("theRoot.game.BGMid.muzzleHero" + lMuzzleIndex++);
            muzzle.x = b.x;
            muzzle.y = b.y;
            if(!theRoot.game.hero.facingRight) {
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
            this.x = theRoot.mouseX;
            this.y = theRoot.mouseY;
            
            if(this.isMouseDown) {
                if(--this.clicksToNextShot <= 0) {
                    this.fireShot(true);
                    this.clicksToNextShot = this.framesBetweenShots;
                }
            }
        }
    }
}