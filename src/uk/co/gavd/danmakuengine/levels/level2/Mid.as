package uk.co.gavd.danmakuengine.levels.level2 
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
			var url:URLRequest = new URLRequest("/graphics/bg/battlestar.png");
			this.addChild(loader);
			loader.load(url);
			loader.x = 300;
			loader.y -= 100;
		}
		
	}

}