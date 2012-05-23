package uk.co.gavd.battleplatforms.levels.level1 
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
			this.tileWidth = 1020;
			this.graphicsPath = "./graphics/bg/starfield_lrg.jpg"; // TODO this should load upfront
			
			this.loadGraphics();
		}	
	}
}