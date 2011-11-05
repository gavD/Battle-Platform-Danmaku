package uk.co.gavd {
	import flash.display.*;
	import uk.co.gavd.enemies.*;
    
	
    public class EnemyGenerator {
		private var game:Game;
		
		
		public function EnemyGenerator(game:Game):void {
			this.game = game;
			trace("CONSTRUCT ENEMY GENERATOR");
		}
		
		public function spawnSpecificEnemyFromPoint(et:Number, spawnPoint:MovieClip):Enemy {
        
			var mc:Enemy = this.spawnSpecificEnemy(et, 100);
			
			mc.x = spawnPoint.x;
			mc.y = spawnPoint.y;
			//game.parent.absDelete(spawnPoint); // TODO
			 
			 trace("::1 Blowing away spawn point " + spawnPoint);
			 trace("::2 Remove");
			 game.BGMid.removeChild(spawnPoint);
			 trace("::3 done " + spawnPoint);
			 spawnPoint = null;
			 trace("::4 done " + spawnPoint);
			 //trace("::4 ENEMY " + mc + " spawned");
			return mc;
		}
    
		public function spawnSpecificEnemy (et:Number, initialAlpha:Number):Enemy {
			trace("Add to " + game.BGMid);
			var t:Enemy = new Turret();
			trace("ADDED " + t);
			game.BGMid.addChild(t);
			t.alpha = initialAlpha;
			t.stop();
			//t.xScaleFactor = 1;
			// todo (MovieClip)root.fcEnemies.registerEnemy(t);
			
			return t;
			
		}
    }
}

    	//private clicks:int = 10;
		
