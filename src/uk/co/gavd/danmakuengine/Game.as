package uk.co.gavd.danmakuengine {
	import flash.display.*;
    import flash.events.*;
	import uk.co.gavd.danmakuengine.levels.Level;
	import uk.co.gavd.danmakuengine.levels.level1.Level1;
	import uk.co.gavd.danmakuengine.levels.layers.Mid;
	import uk.co.gavd.danmakuengine.levels.layers.Artifacts;
	import uk.co.gavd.danmakuengine.levels.layers.Deep;
	
    public class Game extends MovieClip {
		
		private var lvl:Level;

		public var hero:Hero;
		
		// todo remove sof
		public var deep:Deep;
		public var mid:Mid;
		public var artifacts:Artifacts;
		// todo remove eof
		private var doScroll:Boolean = true;
		
		private var config:Config;
		
		public function Game() {
			this.hero = new Hero();
		}
		
		public function setConfig(config:Config):void {
			this.config = config;
		}
		
		public function loadLevel(level:Number):void {
			this.lvl = new Level1();
			this.addChild(this.lvl);
			this.lvl.setHero(this.hero);
			
			this.deep = this.lvl.deep;
			this.mid = this.lvl.mid;
			this.artifacts = this.lvl.artifacts;
		}
		
		public function stopScrolling():void {
			doScroll = false;
		}
		
		public function startScrolling():void {
			doScroll = true;
		}
		
		public function onFrame(event:Event):void {
			if(!doScroll) {
				return;
			}
			
			this.lvl.artifacts.x -= Config.SCROLL_SPEED;
			this.lvl.mid.x = this.artifacts.x;
			this.lvl.deep.x -= Config.SCROLL_SPEED * 5.2;
			if (this.lvl.deep.x < (this.lvl.deep.tileWidth * -1)) {
				this.lvl.deep.x += this.lvl.deep.tileWidth;
			}
		}
	}
}