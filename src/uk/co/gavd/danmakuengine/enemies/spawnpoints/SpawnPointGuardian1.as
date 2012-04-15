package uk.co.gavd.danmakuengine.enemies.spawnpoints {
	import flash.display.MovieClip;
	
	public class SpawnPointGuardian1 extends MovieClip {
		
		public function SpawnPointGuardian1() {
			// constructor code
		}
		 
		public function dispose():void
		{
			// clean up after ourself!
			stop();
		}
	}
	
}
