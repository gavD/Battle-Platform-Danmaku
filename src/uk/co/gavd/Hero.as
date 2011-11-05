package uk.co.gavd {
    import flash.display.*;
    import flash.events.*;
    
    public class Hero extends MovieClip {
        
        protected var theRoot:MovieClip = MovieClip(root);
        
        public var power:Number = 1;
        
        public var lAction:Number = OK;
        public var OK:Number = 0; // TODO convert to eval
        public var DYING:Number = 1;
    
        private var bInvincible:Boolean = false;

		private var lInertiaX:Number = 0;
        private var lInertiaY:Number = 0;
        private var inertiaLimit:Number = 5;
        private var lTotalMvt:Number = 0;
    
        // inertia and speed
        private var lRatioVertical:Number = 0.2;
        private var slowDownRatio:Number = 1.2; // used in inertia
        private var lEngineSpeedIncrement:Number = 0.8;
        private var oppositeRatio:Number = 2; // if you move in the opposite direction to current
                                      // inertia, how much should movement be modified by
            
		public var lEnergy:Number = 0;
		private var lMaxEnergy:Number = 40;
		
		public var thrusterRear:MovieClip;
		public var thrusterFront:MovieClip;
		public var thrusterTop:MovieClip;
		public var thrusterBottom:MovieClip;
		
		public var hitZone:MovieClip;
        
        public function applyMovement(lXDir:Number, lYDir:Number):void {
            this.setThrusters(lXDir, lYDir);
            this.setInertia(lXDir, lYDir);
      
        }
        
        private function setThrusters(lXDir:Number, lYDir:Number):void {
            // TDODO if (theRoot.bGamePaused) {return;}
            this.thrusterRear.visible = false;
            this.thrusterFront.visible = false;
            this.thrusterTop.visible = false;
            this.thrusterBottom.visible = false;
            if (lXDir > 0) {
                this.thrusterFront.visible = true;
            } else if (lXDir < 0) {
                this.thrusterRear.visible = true;
            }
            if (lYDir > 0) {
                this.thrusterTop.visible = true;
            } else if (lYDir < 0) {
                this.thrusterBottom.visible = true;
            }
        }
        
        private function setInertia(lXDir:Number, lYDir:Number):void {
            if (lXDir == 0) { // neutral
                if (lInertiaX > 0) {
                    lInertiaX -= lEngineSpeedIncrement * slowDownRatio;
                    if (lInertiaX < lEngineSpeedIncrement) {
                        lInertiaX = 0;
                    }
                } else if (lInertiaX < 0) {
                    lInertiaX += lEngineSpeedIncrement * slowDownRatio;
                    if (lInertiaX > (-lEngineSpeedIncrement)) {
                        lInertiaX = 0;
                    }
                }
            } else if (lXDir > 0) { // pressingright
                if (lInertiaX < 0) { // double duty
                    lInertiaX += lEngineSpeedIncrement * slowDownRatio * oppositeRatio;
                }
                lInertiaX += lEngineSpeedIncrement;
            } else { // pressing left
                if (lInertiaX > 0) { // double duty
                    lInertiaX -= lEngineSpeedIncrement * slowDownRatio * oppositeRatio;
                }
                lInertiaX -= lEngineSpeedIncrement;
            }
            
            // scrolling management
            if (lInertiaX != 0)
            {
				if (lInertiaX > 0 && this.x < 10) {
					lInertiaX = 0;
				} else if (lInertiaX < 0 && this.x > 700) {
					lInertiaX = 0;
				} else {
					// cap the limits
					if (lInertiaX > inertiaLimit) {
						lInertiaX = inertiaLimit;
					} else if (lInertiaX < -inertiaLimit) {
						lInertiaX = -inertiaLimit;
					}
					this.x -= lInertiaX;
				}
            }
    
            this.rotation = -lInertiaX;
    
            if (lYDir > 0) {        // going down
                if (lInertiaY < 0) { // double duty
                    lInertiaY += lEngineSpeedIncrement * slowDownRatio * oppositeRatio;
                }
                lInertiaY += (lEngineSpeedIncrement * lRatioVertical);
            } else if (lYDir < 0) {  // going up
                if (lInertiaY > 0) { // double duty
                    lInertiaY -= lEngineSpeedIncrement * slowDownRatio * oppositeRatio;
                }
                lInertiaY -= (lEngineSpeedIncrement * lRatioVertical);
            } else { // neutral
                if (lInertiaY > 0) {
                    lInertiaY -= lEngineSpeedIncrement * slowDownRatio * lRatioVertical;
                } else if (lInertiaY < 0) {
                    lInertiaY += lEngineSpeedIncrement * slowDownRatio * lRatioVertical;
                }
            }
            
            if (
                (lInertiaY < 0 && (this.y < theRoot.SCROLL_BOUNDSy_UPPER))
                ||
                (lInertiaY > 0 && (this.y > theRoot.SCROLL_BOUNDSy_LOWER))
                )
            {
                lInertiaY = 0;
            } else {
                // cap the limits
                if (lInertiaY > inertiaLimit) {
                    lInertiaY = inertiaLimit;
                    //trace("CAP HIT");
                } else if (lInertiaY < -inertiaLimit) {
                    lInertiaY = -inertiaLimit;
                    //trace("CAP HIT");
                }
    
                //trace("Inertia : " + lInertiaX + "," + lInertiaY);
                this.y += lInertiaY;
                if (this.y > theRoot.SCROLL_BOUNDSy_LOWER) {
                    this.y = theRoot.SCROLL_BOUNDSy_LOWER;
                    lInertiaY = 0;
                }
            }        
        }
        
        /*
        public function reset():void {
            trace("*************RESET****************");
            theRoot.game.rotation = 0;
            
            theRoot.bGamePaused = true;
            theRoot.fcGameOver.visible = true;
            theRoot.fcGameOver.play();
        }
        
        public function init(bInvincibleThis:Boolean):void {
            this.visible = true;
            lInertiaX = 0;
            lInertiaY = 0;
            this.lEnergy = this.lMaxEnergy;
            
            this.lAction = OK;
            this.x = 250;
            this.y = 180;
            bInvincible = bInvincibleThis;
            if (bInvincible) {
                theRoot.fcBlinker.doInvincible();
            }
        }
    */
        public function takeHit(lDamage:Number):void {
            if (lAction == DYING) {
                return;
            } else if (bInvincible && lDamage < 1500) {
                return;
            }
            
//            theRoot.takeHit.gotoAndPlay(2);
//			  theRoot.fcBlinker.gotoAndStop(1);
            this.visible = true;
            lEnergy -= lDamage;
            
            if (lEnergy <= 0) {
                lAction = DYING;
                this.gotoAndPlay("die");
            } else {
                this.gotoAndPlay("takeHit");
//                theRoot.sfxEnemyExplosions.gotoAndPlay("heroTakeHit");
            }
        }
		
        /*
    // TODO    public function onLoad() {
    //         this.init(true);    
    //     }
        */
        public function doFrame(event:Event) {
            //if (theRoot.bGamePaused) { return; } // TODO
            //else if (lAction == DYING) { return; }
    
            var lXDir:Number = 0;
            var lYDir:Number = 0;
            
            if (theRoot.isKeyPressed(68)) { // d
                lXDir = -1;
            } else if (theRoot.isKeyPressed(65)) { // a
                lXDir = 1;
            }
            if (theRoot.isKeyPressed(87)) { // w
                lYDir = -1;
            } else if (theRoot.isKeyPressed(83)) { //s
                lYDir = 1;
            }
            this.applyMovement(lXDir,lYDir);
        }
		
    }
}