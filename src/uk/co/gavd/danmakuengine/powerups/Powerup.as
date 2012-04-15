package uk.co.gavd.danmakuengine.powerups {
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.media.Sound;
	import uk.co.gavd.danmakuengine.Hero;
    
    public class Powerup extends MovieClip {
		
		protected var powerupWav:Sound;
		
		public function Powerup() {
			this.powerupWav = new PowerupROFWav();
			this.addEventListener ( Event.ENTER_FRAME, this.doFrame, false, 0, true);
		}
		
		public function doFrame(e:Event) {
			if(MovieClip(root).game.hero.lAction !== Hero.OK) {
				return;
			}
            if (this.hitTestObject(MovieClip(root).game.hero.hitZone)) {
				this.powerupWav.play();
				this.removeEventListener(Event.ENTER_FRAME, this.doFrame, false);
                this.upgrade();
				parent.removeChild(this); // TODO seriously, why is it so hard to delete things in AS3?
            	delete this;		      //      I'm not at all convinced this is actually removed...
            }
		}
		
		protected function upgrade():void {
			MovieClip(root).reticle.powerupROF();
		}
    }
}
