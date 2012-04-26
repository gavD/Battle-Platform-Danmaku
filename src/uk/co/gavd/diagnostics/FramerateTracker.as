package uk.co.gavd.diagnostics
{
    import flash.utils.getTimer;
    import flash.events.Event;
    import flash.display.Sprite;
    import flash.text.TextField;
    
	/**
	 * Adapted from GuiltFilter's code on
	 * http://www.actionscript.org/forums/showthread.php3?t=171724
	 *
	 * Modified to supply an average over the last second
	 */
    public class FramerateTracker extends Sprite
    {
        private var time:int;
        private var prevTime:int = 0;
        private var fps_txt:TextField;
		private var fps_log:Array;
        
        public function FramerateTracker(fps:uint)
        {
			this.init(fps);
			addEventListener(Event.ENTER_FRAME, this.onGetFps);
        }
		
		private function init(fps:uint):void
		{
			this.fps_txt = new TextField();
            addChild(this.fps_txt);
			
			this.fps_log = [];
			for(var i:uint = 0; i < fps; i++) {
				this.fps_log.push(fps);
			}
            
		}
        
        private function onGetFps(e:Event):void
        {
            this.time = getTimer();
			this.fps_log.shift();
			var curFps:Number = 1000 / (time - prevTime);
			this.fps_log.push(curFps);
			var total:Number = 0;
			var l:uint = this.fps_log.length;
			for(var i:uint = 0; i < l; i++) {
				total += this.fps_log[i];
			}
			var fps:uint = total / this.fps_log.length;
            this.fps_txt.text = "fps: " + fps;
            this.prevTime = getTimer();
        }
    }
}