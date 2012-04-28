package uk.co.gavd.danmakuengine {
    import flash.display.*;
    import flash.events.*;
	import uk.co.gavd.danmakuengine.ballistics.*;
	import flash.media.Sound;
    
    public class Reticle extends MovieClip {
        private var lShotIndex:uint = 0;
        private var isMouseDown:Boolean = false;
        private var framesBetweenShots:uint = 10;
        private var clicksToNextShot:uint = 0;
        
		private var game:Game;
		private var config:Config;
		
		private const MIN_FRAMES_BETWEEN_SHOTS:uint = 3;
		
		private var cannonWav:Sound;

		public function Reticle(game:Game, config:Config) {
			this.game = game;
			this.config = config;
			this.cannonWav = new CannonWav;
		}
		
		public function powerupROF():void {
			this.framesBetweenShots -= 2;
			if(this.framesBetweenShots < MIN_FRAMES_BETWEEN_SHOTS) {
				this.framesBetweenShots = MIN_FRAMES_BETWEEN_SHOTS;
			}
			trace("ROF is now " + this.framesBetweenShots);
		}
        
        public function fireShot(directional:Boolean):void {
			if (game.hero.lAction != Hero.OK) {
                // trace("HERO NOT OK - CAN'T FIRE");
                return;
            }
            
            // fire a bullet
            lShotIndex++;
			
			var b:BulletHero = this.getNextBullet();
			
            if(directional) {
                var virtualCursorX:int = this.x - game.x - game.BGMid.x;
				var virtualCursorY:int = this.y;
				
				virtualCursorX += (Math.random() * 30) - 15;
				virtualCursorY += (Math.random() * 30) - 15;
				
                b.fireAtPoint(virtualCursorX, virtualCursorY, true);
            } else { // straight line fire
                b.fireAtPoint(b.x + 750, b.y);
            }
			
			cannonWav.play();
			
			if(game.hero.spreadShot > 0) {
				var b2:BulletHero = this.getNextBullet();
				b2.fireAtPoint(b2.x + 10, b2.y + 4, true);
				
				this.getNextBullet().fireAtPoint(b2.x + 10, b2.y - 4, true);
				if(game.hero.spreadShot > 1) {
					this.getNextBullet().fireAtPoint(b2.x + 10, b2.y + 1, true);
					this.getNextBullet().fireAtPoint(b2.x + 10, b2.y - 1, true);
				}
			}
        }
		
		private function getNextBullet():BulletHero {
			var b:BulletHero = new BulletHero(game);
			
            b.x = game.hero.x - game.BGMid.x + 55;
            b.y = game.hero.y + 12;
			game.BGMid.addChild(b); 
			
			return b;
		}
        
        public function doMouseDown(event:MouseEvent):void {
            this.isMouseDown = true;
        }
        public function doMouseUp(event:MouseEvent):void {
            this.clicksToNextShot = 0;
            this.isMouseDown = false;
        }
        
        public function onFrame(e:Event):void {
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