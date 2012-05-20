package uk.co.gavd.danmakuengine.levels.level1 
{
	import uk.co.gavd.danmakuengine.levels.Level;
	
	/**
	 * ...
	 * @author Gavin Davies
	 */
	public class Level1 extends Level
	{
		
		public function Level1() 
		{
			this.deep = new Deep();
			this.mid = new Mid();
			this.artifacts = new Artifacts();
		}
	}
}