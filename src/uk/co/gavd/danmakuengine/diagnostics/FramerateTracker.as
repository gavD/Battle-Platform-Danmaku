package uk.co.gavd.danmakuengine.diagnostics
{
    import flash.utils.getTimer;
    import flash.events.Event;
    import flash.display.Sprite;
    import flash.text.TextField;
    
	/**
	 * Adapted from GuiltFilter's code on
	 * http://www.actionscript.org/forums/showthread.php3?t=171724
	 */
    public class FramerateTracker extends Sprite
    {
        private var time:int;
        private var prevTime:int = 0;
        private var fps:int;
        private var fps_txt:TextField;
        
        public function FramerateTracker()
        {
            this.fps_txt = new TextField();
            addChild(this.fps_txt);
            
            addEventListener(Event.ENTER_FRAME, this.getFps);
        }
        
        private function getFps(e:Event):void
        {
            this.time = getTimer();
            this.fps = 1000 / (time - prevTime);
            this.fps_txt.text = "fps: " + fps;
            this.prevTime = getTimer();
        }
    }
}