package uk.co.gavd.danmakuengine.enemies
{
	import flash.display.MovieClip;
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.Config;
	import uk.co.gavd.diagnostics.ClassUtils;
	import flash.display.DisplayObject;
	
	public class EnemyGenerator
	{
		private var game:Game;
		private var fcEnemies:EnemyCollection;
		
		protected var config:Config;
		
		public function EnemyGenerator(game:Game, fcEnemies:EnemyCollection, config:Config)
		{
			this.game = game;
			this.fcEnemies = fcEnemies;
			this.config = config;
		}
		
		public function detectEnemies():void {
			var len:uint = game.BGMid.numChildren;
			for (var i:uint = 0; i < len; i++) {  
				var display:DisplayObject = game.BGMid.getChildAt(i);  
				
				if (display is Enemy) {
					Enemy(display).setGame(this.game);
					Enemy(display).stop();
					fcEnemies.registerEnemy(Enemy(display));
				}
			}  
		}
	}
}