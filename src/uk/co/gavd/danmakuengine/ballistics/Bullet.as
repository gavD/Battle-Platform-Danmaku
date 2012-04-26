package uk.co.gavd.danmakuengine.ballistics {
    import flash.display.MovieClip;
    import flash.events.Event;
    import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.Hero;
    
    public class Bullet extends MovieClip {
		
        // dynamically calculated stuff
        public var triggered:Boolean = false;
        protected var framesToLive:int = 10000;
        protected var xTravel:Number = 0;
        protected var yTravel:Number = 0;
        
        // info about this bullet
        protected var damage:Number = 5;
        protected var travel:Number = 750; // how many px this bullet can fly
		
		protected var lSpeed:Number = 2.5;
		
		protected var game:Game;
		
		
		public function Bullet(game:Game) {
			this.stop();
			this.game = game;
			this.hitArea.visible = false;
			this.addEventListener(Event.ENTER_FRAME, this.onFrame, false, 0, true);
		}
        
        public function fireAtPoint(targetX:Number, targetY:Number, rotateToFace:Boolean = false):void {
            var angle:Number = this.getAngleTo(targetX, targetY);
            
            var opp:Number = Math.sin(angle) * travel; // opp = h * s
            var adj:Number = Math.cos(angle) * travel; // adj = h * c
            
            this.calculateTravelPerFrame(adj, opp);
            this.calculateFramesToLive(targetY);
			
			if(rotateToFace) {
				var myRadians:Number = Math.atan2( this.y - targetY, this.x - targetX );
               	this.rotation = (myRadians * (180 / Math.PI)) + 180;
			}
        }
        
        public function fireAtAngle(degrees:Number):void {
            var radians:Number = degrees * Math.PI / 180;
            var opp:Number = Math.sin(radians) * travel; // opp = h * s
            var adj:Number = Math.cos(radians) * travel; // adj = h * c
            this.fireAtPoint(this.x + opp, this.y + adj);
        }
        
        public function fireAtTarget(target:MovieClip):void {
            this.fireAtPoint(target.x - game.BGMid.x, target.y);
		}
        
        private function getAngleTo(aimAtX:Number, aimAtY:Number):Number {
            return Math.atan2(aimAtY - this.y, aimAtX- this.x);
        }
        
        private function calculateTravelPerFrame(xRem:Number, yRem:Number):void {
            // calculate speed of movement per frame
            this.xTravel = this.lSpeed * (xRem / (Math.abs(xRem) + Math.abs(yRem)));
            this.yTravel = this.lSpeed - Math.abs(xTravel);
        }
        
        private function calculateFramesToLive(targetY:Number):void {
            // work out how long this bullet has to live
            var defaultFramesToLive:uint = this.travel / this.lSpeed;
            var ticksToOutOfY:uint = defaultFramesToLive;
    
            if (targetY < y) {
                ticksToOutOfY = (y + 50) / yTravel;
                this.yTravel *= -1;
            } else if (targetY > y) {
                ticksToOutOfY = ((this.stage.stageHeight + 50) - y) / yTravel;
            }
            
            this.framesToLive = (ticksToOutOfY < defaultFramesToLive) ? ticksToOutOfY : defaultFramesToLive;
            
            //trace("ticksToOutOfY=" + ticksToOutOfY + ", default=" + Math.round(this.travel / this.getSpeed()) + " : Final ticks are " + framesToLive);
        }
        
        private function moveTowardsTarget():void {
            
            this.x += this.xTravel;
            this.y += this.yTravel;
    
            if (--this.framesToLive <= 0) {
                
                if(!this.triggered) {
                    this.triggered = true;
                    this.gotoAndPlay("explode");
                }
                this.xTravel /= 2; // slow the bullet
                this.yTravel /= 2; // slow the bullet
            }
        }
        
        public function onFrame(e:Event):void {
            this.moveTowardsTarget();
            if(this.triggered) {
                return;
            }
            this.checkForHits();
        }
        
        protected function checkForHits():void {
			if( game.hero.lAction != Hero.OK ) {
				return;
			}
			
			if (this.hitArea.hitTestObject(game.hero.hitArea)) {
				this.triggered = true;
                game.hero.takeHit(this.damage);
                this.gotoAndPlay("explode");
            } else {
				if(this.hitArea.hitTestObject(game.hero)) {
					MovieClip(root).comboBar.ticksUp();
					MovieClip(root).scoreDisplay.scoreUp(1); // TODO magic number
					// TODO hero sparks
				}
			}
        }
		
		public function blam():void {
			this.removeEventListener(Event.ENTER_FRAME, this.onFrame);
			this.parent.removeChild(this);
			this.dispose();
		}
		
		public function dispose() {
			this.stop();
		}
    }
}