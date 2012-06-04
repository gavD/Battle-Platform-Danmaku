package uk.co.gavd.battleplatforms.levels.level4 
{
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.levels.Level;
	
	/**
	 * ...
	 * @author Gavin Davies
	 */
	public class Level4 extends uk.co.gavd.danmakuengine.levels.Level
	{
		
		public function Level4() 
		{
			this.deep = new Deep();
			this.mid = new Mid();
			
			this.artifacts = new Artifacts();
			
			this.addChild(this.deep);
			this.addChild(this.mid);
		}

		override public function isComplete():Boolean {
			return false; // TODO some way of completing the game
		}
	}
}