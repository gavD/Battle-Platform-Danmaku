package uk.co.gavd.danmakuengine {
    import flash.display.MovieClip;
	import flash.display.Stage;
    import flash.events.Event;
	import uk.co.gavd.danmakuengine.Filters;
    
    public class Hero extends MovieClip {
        
        protected var theRoot:MovieClip = MovieClip(root);
        
        public var power:Number = 1;
		
		public var isFiring:Boolean = false;
        
        public var lAction:Number = OK;
		public static const OK:Number = 0;
        public static const TAKING_HIT:Number = 1;
		public static const DYING:Number = 2;
		
    
        private var bInvincible:Boolean = false;

        private var inertiaLimit:Number = 9; // TODO can these switch 
    
        // inertia and speed
        private var lRatioVertical:Number = 0.2;
        private var lMaxEnergy:int = 40;
		public var lEnergy:Number = lMaxEnergy;
		
		public var thrusterRear:MovieClip;
		public var thrusterFront:MovieClip;
		public var thrusterTop:MovieClip;
		public var thrusterBottom:MovieClip;
		
		public var hitZone:MovieClip;
		
		private var hitTaker:HitTaker;
		
		public function Hero() {
			this.hitTaker = new HitTaker(this);
		}
		
		public function getMaxEnergy():int {
			return this.lMaxEnergy;
		}
		
		public function getEnergy():int {
			return this.lEnergy;
		}
		
		
		// the area the ship can't fly into around the sides
		// of the screen
		private static const SCREEN_BORDER = 15;
        
        public function applyMovement(lXDir:Number, lYDir:Number):void {
            this.setThrusters(lXDir, lYDir);
			this.x += lXDir * inertiaLimit * lRatioVertical; 
			this.y += lYDir * inertiaLimit * lRatioVertical;
			
			if(this.y < SCREEN_BORDER) {
				this.y = SCREEN_BORDER;
			} else if (this.y > (stage.stageHeight-SCREEN_BORDER)) {
				this.y = stage.stageHeight-SCREEN_BORDER;
			}
			
			if(this.x < SCREEN_BORDER + 20) {
				this.x = SCREEN_BORDER + 20;
			} else if (this.x > (stage.stageWidth-SCREEN_BORDER - 30)) {
				this.x = stage.stageWidth - SCREEN_BORDER - 30;
			}
        }
		
		public function setAction(a:int):void {
			this.lAction = a;
		}
        
        private function setThrusters(lXDir:Number, lYDir:Number):void {
            // TDODO if (theRoot.bGamePaused) {return;}
            this.thrusterRear.visible = false;
            this.thrusterFront.visible = false;
            this.thrusterTop.visible = false;
            this.thrusterBottom.visible = false;
            if (lXDir < 0) {
                this.thrusterFront.visible = true;
            } else if (lXDir > 0) {
                this.thrusterRear.visible = true;
            }
            if (lYDir > 0) {
                this.thrusterTop.visible = true;
            } else if (lYDir < 0) {
                this.thrusterBottom.visible = true;
            }
        }
        
        
        public function reset():void {
			trace("INSIDE HERO RESET");
			this.lAction = Hero.OK;
			//theRoot.fcBlinker.doInvincible();
			this.lEnergy = this.lMaxEnergy;
			this.gotoAndStop("ready");
        }

		public function takeHit(lDamage:Number):void {
            if (lAction == DYING || lAction == TAKING_HIT) {
                return;
            } else if (bInvincible && lDamage < 1500) {
                return;
            } else if (this.hitTaker.isFiltered()) {
				return;
			}
            
            this.lEnergy -= lDamage;
            
            if (lEnergy <= 0) {
                this.lAction = Hero.DYING;
                this.gotoAndPlay("die");
            } else {
				this.hitTaker.takeHit(10);
            }
        }
		
        public function doFrame(event:Event):void {
			hitTaker.doFrame(); // TODO can we factor it out?
			
			if(this.lAction >= DYING) {
				return;
			}
            //if (theRoot.bGamePaused) { return; } // TODO
            //else if (lAction == DYING) { return; }
    
            var lXDir:Number = 0;
            var lYDir:Number = 0;
            
            if (theRoot.isKeyPressed(68)) { // d
                lXDir = 1;
            } else if (theRoot.isKeyPressed(65)) { // a
                lXDir = -1;
            }
            if (theRoot.isKeyPressed(87)) { // w
                lYDir = -1;
            } else if (theRoot.isKeyPressed(83)) { //s
                lYDir = 1;
            }
			//if(!theRoot.isKeyPressed(16)) { // shift
			if(!this.isFiring) { // shift
				lXDir *= 2;
				lYDir *= 2;
			}
            this.applyMovement(lXDir,lYDir);
        }
		
		public function repairArmor():void {
			this.lEnergy = this.lMaxEnergy;
		}
    }
}