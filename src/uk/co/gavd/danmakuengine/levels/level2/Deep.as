package uk.co.gavd.danmakuengine.levels.level2 
{
	import uk.co.gavd.danmakuengine.levels.layers.Deep;
	
	/**
	 * ...
	 * @author Gavin Davies
	 */
	public class Deep extends uk.co.gavd.danmakuengine.levels.layers.Deep
	{
		
		public function Deep() 
		{
			this.tileWidth = 960;
			this.graphicsPath = "/graphics/bg/starfield_lrg_2.jpg"; // TODO this should load upfront
			
			this.loadGraphics();
		}	
	}
}