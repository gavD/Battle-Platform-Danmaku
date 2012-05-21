package uk.co.gavd.danmakuengine.levels 
{
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.Hero;
	import uk.co.gavd.danmakuengine.levels.layers.Deep;
	import uk.co.gavd.danmakuengine.levels.layers.Mid;
	import uk.co.gavd.danmakuengine.levels.layers.Artifacts;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Gavin Davies
	 */
	public class Level extends MovieClip
	{
		public var deep:Deep;
		public var mid:Mid;
		public var artifacts:Artifacts;
		public var hero:Hero;
		
		public function Level() {
		}
		
		public function setHero(h:Hero):void {
			this.hero = h;
			this.addChild(this.hero);
			this.addChild(this.artifacts);
			this.hero.y = 200;
			this.hero.x = 40;
		}
		
	}

}