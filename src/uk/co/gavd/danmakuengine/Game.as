package uk.co.gavd.danmakuengine {
	import flash.display.*;
    import flash.events.*;
	import uk.co.gavd.danmakuengine.ballistics.Bullet;
	import uk.co.gavd.danmakuengine.enemies.EnemyCollection;
	import uk.co.gavd.danmakuengine.enemies.EnemyGenerator;
	import uk.co.gavd.danmakuengine.levels.Level;
	import uk.co.gavd.danmakuengine.levels.level1.Level1;
	import uk.co.gavd.danmakuengine.levels.layers.Mid;
	import uk.co.gavd.danmakuengine.levels.layers.Artifacts;
	import uk.co.gavd.danmakuengine.levels.layers.Deep;
	import uk.co.gavd.danmakuengine.levels.level2.Level2;
	import uk.co.gavd.danmakuengine.powerups.Powerup;
	import uk.co.gavd.diagnostics.TimelineUtils;
	
    public class Game extends MovieClip {
		
		private var lvl:Level;

		public var hero:Hero;
		
		// todo remove sof
		public var deep:Deep;
		public var mid:Mid;
		public var artifacts:Artifacts;
		// todo remove eof
		private var doScroll:Boolean = true;
		
		private var config:Config;
		
		public function Game() {
			this.hero = new Hero();
		}
		
		public function setConfig(config:Config):void {
			this.config = config;
		}
		
		public function loadLevel(level:uint):void {
			trace("Load level " + level);
			if(level === 1) {
				this.lvl = new Level1();
			} else {
				this.lvl = new Level2();
			}
			
			this.addChild(this.lvl);
			this.lvl.setHero(this.hero);
			
			this.deep = this.lvl.deep;
			this.mid = this.lvl.mid;
			this.artifacts = this.lvl.artifacts;
			
			enemyGenerator.detectEnemies(this.lvl.artifacts); // TODO is this in the right place? Should it it be called earlier?
			// well, at least, fcEnemies should be told to killAll earlier, right?
		}
		
		public function stopScrolling():void {
			doScroll = false;
		}
		private var enemyGenerator:EnemyGenerator; // TODO tidy this up
		public function setEnemyGenerator(enemyGenerator:EnemyGenerator) {
			this.enemyGenerator = enemyGenerator;
		}
		private var enemyCollection:EnemyCollection; // TODO tidy this up
		public function setEnemyCollection(enemyCollection:EnemyCollection) {
			this.enemyCollection = enemyCollection;
		}
		
		public function startScrolling():void {
			doScroll = true;
		}
		
		public function onFrame(event:Event):void {
			if(!doScroll) {
				return;
			}
			
			this.lvl.scroll();
			
			if (this.lvl.isComplete()) {
				this.levelUp();
			}
		}
		
		private function levelUp():void {
			this.enemyCollection.killAll(true);
			this.lvl.clearAll();
			this.removeChild(this.lvl);
			this.loadLevel(2);
		}
		
	}
}