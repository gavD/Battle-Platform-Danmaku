package uk.co.gavd.battleplatforms.levels.level3 
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
			this.tileWidth = 1281;
			this.graphicsPath = "./graphics/bg/5408_3d_space_scene_hd_wallpapers.jpg"; // TODO this should load upfront
			
			this.loadGraphics();
		}	
	}
}