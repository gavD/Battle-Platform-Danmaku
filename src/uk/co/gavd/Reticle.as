package uk.co.gavd {
    import flash.display.*;
    import flash.events.*;
	import uk.co.gavd.Hero;
	import uk.co.gavd.ballistics.*;
	import flash.media.Sound;
    
    public class Reticle extends MovieClip {
        private var lShotIndex:Number = 0;
        private var lMuzzleIndex:Number = 0;
        private var isMouseDown:Boolean = false;
        private var framesBetweenShots:Number = 9;
        private var clicksToNextShot:Number = 0;
        
		private var game:Game;
		private var config:Config;
		
		private var cannonWav:Sound;

		public function Reticle(game:Game, config:Config) {
			this.game = game;
			this.config = config;
			this.cannonWav = new CannonWav;
		}
		
		public function powerupROF():void {
			trace("POWER UP ROF was " + this.framesBetweenShots);
			this.framesBetweenShots -= 3;
			if(this.framesBetweenShots < 3) {
				this.framesBetweenShots = 3;
			}
			trace("POWER UP ROF now " + this.framesBetweenShots);
		}
        
        public function fireShot(directional:Boolean):void {
            //if (bGamePaused) {
              //  trace("GAME PAUSED - CAN'T FIRE");
                //return;
            //} else // TODO
			if (game.hero.lAction != Hero.OK) {
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
				var virtualCursorY:Number = this.y;
				
				virtualCursorX += (Math.floor(Math.random() * 50) - 25);
				virtualCursorY += (Math.floor(Math.random() * 50) - 25);
				
                b.fireAtPoint(virtualCursorX, virtualCursorY);
                var myRadians:Number = Math.atan2( b.y - b.targetY, b.x - b.targetX );
                b.rotation = (myRadians * (180 / Math.PI)) + 180;
            } else { // straight line fire
                b.fireAtPoint(b.x + 750, b.y);
            }
			
            b.addEventListener(Event.ENTER_FRAME, b.doFrame, false, 0, true);
			cannonWav.play();
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
        }
        public function doMouseUp(event:MouseEvent):void {
            this.clicksToNextShot = 0;
            this.isMouseDown = false;
        }
        
        public function doFrame(e:Event):void {
			this.x = game.parent.mouseX;
            this.y = game.parent.mouseY;
			
			game.hero.isFiring = this.isMouseDown;
            
            if(this.isMouseDown) {
                if(--this.clicksToNextShot <= 0) {
                    this.fireShot(true);
                    this.clicksToNextShot = this.framesBetweenShots;
                }
            }
        }
    }
}