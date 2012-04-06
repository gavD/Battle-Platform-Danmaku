package uk.co.gavd.enemies {
	import flash.display.*;
	import uk.co.gavd.Game;
	import uk.co.gavd.Config;

    public class EnemyGenerator {
		
		private var game:Game;
		private var fcEnemies:EnemyCollection;
		
		protected var config:Config;
		
		public function EnemyGenerator(game:Game, fcEnemies:EnemyCollection, config:Config):void {
			this.game = game;
			this.fcEnemies = fcEnemies;
			this.config = config;
		}
		
		public function spawnSpecificEnemyFromPoint(et:Number, spawnPoint:MovieClip):Enemy {
        
			var mc:Enemy = this.spawnSpecificEnemy(et, 100);
			
			mc.x = spawnPoint.x;
			mc.y = spawnPoint.y;
			 
			game.BGMid.removeChild(spawnPoint);
			spawnPoint.dispose();
			spawnPoint = null;
			 
			return mc;
		}
    
		public function spawnSpecificEnemy (et:Number, initialAlpha:Number):Enemy {
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
			t.alpha = initialAlpha;
			t.stop();
			fcEnemies.registerEnemy(t);
			
			return t;
		}
    }
}