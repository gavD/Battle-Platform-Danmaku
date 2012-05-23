package uk.co.gavd.battleplatforms.levels.level1 
{
	import uk.co.gavd.danmakuengine.levels.layers.Mid;
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Gavin Davies
	 */
	public class Mid extends uk.co.gavd.danmakuengine.levels.layers.Mid
	{
		
		public function Mid() 
		{
			var loader:Loader = new Loader();
			trace("fetch /graphics/bg/ship1.png");
			var url:URLRequest = new URLRequest("./graphics/bg/ship1.png");
			trace("done");
			this.addChild(loader);
			loader.load(url);
			loader.x = 300;
			loader.y -= 100;
		}
		
	}

}