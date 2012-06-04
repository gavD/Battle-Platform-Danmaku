package uk.co.gavd.battleplatforms.levels.level4 
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
			this.tileWidth = 1920;
			this.graphicsPath = "./graphics/bg/space_stars_desktop_1920x1080_wallpaper-123172.jpeg.jpg"; // TODO this should load upfront
			
			this.loadGraphics();
		}	
	}
}