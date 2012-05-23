package uk.co.gavd.danmakuengine.levels 
{
	/**
	 * ...
	 * @author Gavin Davies
	 */
	public class LevelCollection 
	{
		private var levels:Array;
		public function LevelCollection() 
		{
			levels = new Array();
		}
		
		public function addLevel(level:Class):void {
			if (level is Level) {
				trace("IS LEVEL");
			} else {
				trace("NOT LEVEL");
			}
			this.levels.push(level);
		}
		
		public function getLevelCount():uint {
			return this.levels.length;
		}
		
		public function getLevelAt(index:uint):Level {
			return new this.levels[index];
		}
	}

}