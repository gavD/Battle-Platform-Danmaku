﻿package uk.co.gavd.danmakuengine {
	import flash.display.MovieClip;
	
	public class SpawnPointTurret extends MovieClip {
		
		public function SpawnPointTurret() {
			// constructor code
		}
		 
		public function dispose():void
		{
			// clean up after ourself!
			stop();
		}
	}
	
}
