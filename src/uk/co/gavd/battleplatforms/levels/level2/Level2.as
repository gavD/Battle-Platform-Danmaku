package uk.co.gavd.battleplatforms.levels.level2 
{
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.levels.Level;
	
	/**
	 * ...
	 * @author Gavin Davies
	 */
	public class Level2 extends uk.co.gavd.danmakuengine.levels.Level
	{
		
		public function Level2() 
		{
			this.deep = new Deep();
			this.mid = new Mid();
			
			this.artifacts = new Artifacts();
			
			this.addChild(this.deep);
			this.addChild(this.mid);
		}
		
		
		override public function isComplete():Boolean {
			return false;
		}
	}
}