package uk.co.gavd.danmakuengine {
    import flash.display.*;
    import flash.events.*;
	import uk.co.gavd.danmakuengine.ballistics.*;
	import flash.media.Sound;
    
    public class Reticle extends MovieClip {
        
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
            var b:BulletHero = this.getNextBullet();
			
            if(directional) {
                var virtualCursorX:int = this.x - game.x - game.BGMid.x;
				var radians:Number = Math.atan2(this.y - b.y, virtualCursorX - b.x);
				b.fireAtAngleRadians(radians);
            } else { // straight line fire
                b.fireAtPoint(b.x + 750, b.y);
            }
			
			cannonWav.play();
			
			if(game.hero.spreadShot > 0) {
				this.getNextBullet().fireAtAngle( -5);
				this.getNextBullet().fireAtAngle(5);
				if (game.hero.spreadShot > 1) {
					this.getNextBullet().fireAtAngle(-12);
					this.getNextBullet().fireAtAngle(12);
					if(game.hero.spreadShot > 2) {
						this.getNextBullet().fireAtAngle(-25);
						this.getNextBullet().fireAtAngle(25);
						if(game.hero.spreadShot > 3) {
							this.getNextBullet().fireAtAngle(-35);
							this.getNextBullet().fireAtAngle(35);
						}
					}
				}
			}
        }
		
		private function getNextBullet():BulletHero {
			var b:BulletHero = new BulletHero(game);
			
            b.x = game.hero.x - game.BGMid.x + 55;
            b.y = game.hero.y + 14;
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
            if (this.isMouseDown) {
				
                if(--this.clicksToNextShot <= 0) {
                    this.fireShot(true);
                    this.clicksToNextShot = this.framesBetweenShots;
                }
            }
        }
    }
}