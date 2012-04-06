package uk.co.gavd.ballistics {
    import flash.display.*
    import flash.events.*;
    import uk.co.gavd.Game;
    
    public class Bullet extends MovieClip {
		public var hitZone:MovieClip;
		
        // dynamically calculated stuff
        public var triggered:Boolean = false;
        protected var framesToLive:int = 10000;
        protected var xTravel:Number = 0;
        protected var yTravel:Number = 0;
        public var targetX:Number = 0; // TODO lock down?
        public var targetY:Number = 0; // TODO lock down?
        
        // info about this bullet
        protected var damage:Number = 5;
        protected var travel:Number = 750; // how many px this bullet can fly
		
		protected var game:Game;
		
		public function getSpeed():int {
			return 5;
		}
		
		public function Bullet(game:Game) {
			this.game = game;
			this.stop();
		}
        
        public function fireAtPoint(targetX:Number, targetY:Number):void {
			trace("Firing at " + targetX + ", " + targetY);
            this.targetX = targetX;
			this.targetY = targetY;// TODO remove
            var angle:Number = this.getAngleTo(targetX, targetY);
            
            var opp:Number = Math.sin(angle) * travel; // opp = h * s
            var adj:Number = Math.cos(angle) * travel; // adj = h * c
            
            this.calculateTravelPerFrame(adj, opp);
            this.calculateFramesToLive(adj, opp);
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
        
        private function getAngleTo(x2:Number, y2:Number):Number {
            return Math.atan2(y2 - this.y, x2 - this.x);
        }
        
        private function calculateTravelPerFrame(xRem:Number, yRem:Number):void {
			trace("Calculating speed from " + this.getSpeed());
            // calculate speed of movement per frame
            this.xTravel = this.getSpeed() * (xRem / (Math.abs(xRem) + Math.abs(yRem)));
            this.yTravel = this.getSpeed() - Math.abs(xTravel);
        }
        
        private function calculateFramesToLive(xRem:Number, yRem:Number):void {
            // work out how long this bullet has to live
            var defaultFramesToLive:Number = Math.round(this.travel / this.getSpeed());
            var ticksToOutOfY:Number = defaultFramesToLive;
    
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
        
        public function doFrame(e:Event):void {
            this.moveTowardsTarget();
            
            if(this.triggered) {
                return;
            }
            
            this.checkForHits();
        }
        
        protected function checkForHits():void {
			if( game.hero.lAction != game.hero.OK ) {
				return;
			}
			
            if (this.hitZone.hitTestObject(game.hero.hitZone)) {
                game.hero.takeHit(this.damage);
                //theRoot.fcEnemies.applyBounceInner(bul, 1); // TODO
                this.gotoAndPlay("explode");
            }
		
        }
		
		public function blam() {
			if(this.parent === null ) {
				// TODO why does this still come up?!?!?! // trace("Already blammed");
				return;
			}
			// TODO remove the event listener
			this.parent.removeChild(this);
			this.dispose();
		}
		
		public function dispose() {
			this.stop();
		}
    }
}