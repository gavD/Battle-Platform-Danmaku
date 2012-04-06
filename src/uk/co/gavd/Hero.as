package uk.co.gavd {
    import flash.display.MovieClip;
	import flash.display.Stage;
    import flash.events.Event;
    
    public class Hero extends MovieClip {
        
        protected var theRoot:MovieClip = MovieClip(root);
        
        public var power:Number = 1;
        
        public var lAction:Number = OK;
		public static const OK:Number = 0;
        public static const DYING:Number = 1;
    
        private var bInvincible:Boolean = false;

        private var inertiaLimit:Number = 7; // TODO can these switch 
    
        // inertia and speed
        private var lRatioVertical:Number = 0.2;
        public var lEnergy:Number = 0;
		private var lMaxEnergy:Number = 40;
		
		public var thrusterRear:MovieClip;
		public var thrusterFront:MovieClip;
		public var thrusterTop:MovieClip;
		public var thrusterBottom:MovieClip;
		
		public var hitZone:MovieClip;
        
        public function applyMovement(lXDir:Number, lYDir:Number):void {
            this.setThrusters(lXDir, lYDir);
			this.x += lXDir * inertiaLimit * lRatioVertical; 
			this.y += lYDir * inertiaLimit * lRatioVertical;
			
			if(this.y < 10) {
				this.y = 10;
			} else if (this.y > (stage.stageWidth-10)) {
				this.y = stage.stageWidth-10;
			}
			
			
			
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
		
        public function doFrame(event:Event) {
			if(this.lAction != OK) {
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
			if(theRoot.isKeyPressed(16)) { // shift
				lXDir *= 3;
				lYDir *= 3;
			}
            this.applyMovement(lXDir,lYDir);
        }
    }
}