package uk.co.gavd.powerups {
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.media.Sound;
    
    public class PowerupROF extends MovieClip {
		
		protected var powerupWav:Sound;
		
		public function PowerupROF() {
			this.powerupWav = new PowerupROFWav();
			this.addEventListener ( Event.ENTER_FRAME, this.doFrame, false, 0, true);
		}
        
		public function doFrame(e:Event) {
            if (this.hitTestObject(MovieClip(root).game.hero.hitZone)) {
				this.powerupWav.play();
				this.removeEventListener(Event.ENTER_FRAME, this.doFrame, false);
                MovieClip(root).reticle.powerupROF();
				parent.removeChild(this); // TODO seriously, why is it so hard to delete things in AS3?
            	delete this;		      //      I'm not at all convinced this is actually removed...
            }
		}
    }
}
