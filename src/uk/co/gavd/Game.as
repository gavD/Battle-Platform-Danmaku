package uk.co.gavd {
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
		
		private var config:Config;
		
		public function Game() {
			this.initBGTiles = this.BGTiles.x;
			this.initBGMidX = this.BGMid.x;
			this.loadLevel(1);
		}
		
		public function setConfig(config:Config) {
			this.config = config;
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
			trace("GDOFRAME");
//			if(theRoot.bGamePaused) {
//				return;
//			}
			this.BGMid.x -= Config.SCROLL_SPEED;
/*
if(this.curLevel == 1 && this.BGMid.x < -4750) {
				trace("LEVEL UP"); // TODO tidy this up
				this.loadLevel(2);
			}
			*/
			this.BGTiles.x -= Config.SCROLL_SPEED * 0.2;
		}
		
		/*
		function restart(config:Config, fcBullets: ):void {
    // TODO
    config.score = 0;
// TODO    game.hero.init(true);
    
    // reset music if necessary
    //confi.sfxMusic.gotoAndPlay("maybeInMay");
    config.bGamePaused = false;
    fcBullets.killAll = false;
    //trace("RESTART");
    //theRoot.fcGameOver.gotoAndStop(1);
    //theRoot.fcGameOver._visible = false;
}
*/
    }
}