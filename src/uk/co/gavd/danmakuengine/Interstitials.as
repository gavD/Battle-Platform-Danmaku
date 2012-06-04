package uk.co.gavd.danmakuengine {
    import flash.display.MovieClip;
	import flash.display.Stage;
    import flash.events.Event;
    
    public class Interstitials extends MovieClip {
        
		private var delayFrames:uint;
		
		public function fadeIn(initialDelayFrames:uint):void {
			this.addEventListener(Event.ENTER_FRAME, this.updateFrame);
			this.alpha = 0.7;
			this.delayFrames = initialDelayFrames;
		}

		public function updateFrame(evt:Event):void {
			if (this.delayFrames > 0) {
				this.delayFrames--;
				return;
			}
			this.alpha -= 0.05;
			if (this.alpha <= 0) {
				this.removeEventListener(Event.ENTER_FRAME, this.updateFrame);
			}
		}
    }
}