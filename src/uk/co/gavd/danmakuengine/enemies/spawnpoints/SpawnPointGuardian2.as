package uk.co.gavd.danmakuengine.enemies.spawnpoints {
	import flash.display.MovieClip;
	
	public class SpawnPointGuardian2 extends MovieClip {
		
		public function SpawnPointGuardian2() {
			// constructor code
		}
		 
		public function dispose():void
		{
			// clean up after ourself!
			stop();
		}
	}
	
}
