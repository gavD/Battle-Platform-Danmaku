package uk.co.gavd.danmakuengine.levels.level1 
{
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.levels.Level;
	
	/**
	 * ...
	 * @author Gavin Davies
	 */
	public class Level1 extends uk.co.gavd.danmakuengine.levels.Level
	{
		
		public function Level1() 
		{
			this.deep = new Deep();
			this.mid = new Mid();
			
			this.artifacts = new Artifacts();
			
			this.addChild(this.deep);
			this.addChild(this.mid);
		}
	}
}