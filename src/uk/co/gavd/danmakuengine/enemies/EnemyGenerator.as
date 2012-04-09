package uk.co.gavd.danmakuengine.enemies {
	import flash.display.MovieClip;
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.Config;

    public class EnemyGenerator {
		
		private var game:Game;
		private var fcEnemies:EnemyCollection;
		
		protected var config:Config;
		
		public function EnemyGenerator(game:Game, fcEnemies:EnemyCollection, config:Config):void {
			this.game = game;
			this.fcEnemies = fcEnemies;
			this.config = config;
		}
		
		public function spawnSpecificEnemyFromPoint(et:int, spawnPoint:MovieClip):Enemy {
        
			var mc:Enemy = this.spawnSpecificEnemy(et);
			
			mc.x = spawnPoint.x;
			mc.y = spawnPoint.y;
			 
			game.BGMid.removeChild(spawnPoint);
			trace("Before dispose " + spawnPoint);
			spawnPoint.dispose();
			spawnPoint = null;
			 
			return mc;
		}
    
		public function spawnSpecificEnemy (et:Number):Enemy {
			trace("Add to " + game.BGMid);
			var t:Enemy
			switch(et) {
				case 2:
					t = new TurretScatter(this.game);
					break;
				case 3:
					t = new Turret4Way(this.game);
					break;
				case 4:
					t = new TurretSpinner(this.game);
					break;
				default:
					t = new Turret(this.game);
					break;
			}
			
			game.BGMid.addChild(t);
			t.stop();
			fcEnemies.registerEnemy(t);
			
			return t;
		}
    }
}