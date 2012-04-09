package uk.co.gavd.danmakuengine {
	public class Config {
		// game tweaks
		public static const DEBUG_MODE:Boolean = true;
		public static const ANGLED_SHOTS:Boolean = true;
		public static const SCROLL_SPEED:Number = 1;
		public static const MAX_ENEMIES:int = 50;
		
		// game boundaries
		public static const SCROLL_BOUNDS_Y_UPPER:int = 22;
		public static const SCROLL_BOUNDS_Y_LOWER:int = 470;
		
		// global variables
		public var score:int = 0;
		public var bGamePaused:Boolean = false;
		public var fireReady:Boolean = true; // TODO factor out
	}
}