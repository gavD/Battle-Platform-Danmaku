package uk.co.gavd.battleplatforms.levels.level3 
{
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.levels.Level;
	
	/**
	 * ...
	 * @author Gavin Davies
	 */
	public class Level3 extends uk.co.gavd.danmakuengine.levels.Level
	{
		
		public function Level3() 
		{
			this.deep = new Deep();
			this.mid = new Mid();
			
			this.artifacts = new Artifacts();
			
			this.addChild(this.deep);
			this.addChild(this.mid);
		}
	}
}