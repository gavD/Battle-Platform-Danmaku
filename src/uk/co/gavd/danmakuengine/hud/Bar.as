package uk.co.gavd.danmakuengine.hud {
    import flash.display.*;
    import flash.events.*;
	
    public class Bar extends MovieClip {
        
		public var green:MovieClip;
		public var red:MovieClip;
		
		protected var barWidth:uint = 100;
		
		public function Bar(barWidth:uint) {
			this.width = barWidth;
			this.alpha = .5;
		}
    }
}