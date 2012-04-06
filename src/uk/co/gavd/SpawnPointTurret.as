package uk.co.gavd {
	
	import flash.display.MovieClip;
	
	
	public class SpawnPointTurret extends MovieClip {
		
		
		public function SpawnPointTurret() {
			// constructor code
		}
		
		 
		public function dispose():void
		{
			// clean up after ourself!
			trace("SHRED spawn point");
			stop();
		}
	}
	
}
