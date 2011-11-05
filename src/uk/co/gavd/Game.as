﻿package uk.co.gavd {
	import flash.display.*;
    import flash.events.*;
	
    public class Game extends MovieClip {

		private var initBGMidX:Number = 0;
		private var initBGTiles:Number = 0;
		private var curLevel:Number = 0;
		protected var theRoot:MovieClip = MovieClip(root);
		public var hero:Hero;
		public var BGTiles:MovieClip;
		public var BGMid:MovieClip;
		
		public function Game() {
			this.initBGTiles = this.BGTiles.x;
			this.initBGMidX = this.BGMid.x;
			this.loadLevel(1);
		}
		
		public function loadLevel(level:Number):void {
			this.curLevel = level;
			this.x = 0;
			this.y = 0;    // Put the game in position. this means it's easier to edit without worrying about getting it out of position
			
			if (level > 1) {
//				theRoot.fcEnemies.killAll(); // TODO
			}
		}
		
		public function doFrame(event:Event):void {
			if(theRoot.bGamePaused) {
				return;
			}
			this.BGMid.x -= theRoot.SCROLL_SPEED;
			if(this.curLevel == 1 && this.BGMid.x < -4750) {
				trace("LEVEL UP"); // TODO tidy this up
				this.loadLevel(2);
			}
			this.BGTiles.x -= theRoot.SCROLL_SPEED * 0.2;
		}
    }
}