var enemyGenerator:Object = {
	clicks: 10,
	enemyIndex: 0,
	
	spawnSpecificEnemyFromPoint:function (et:Number, spawnPoint:MovieClip):MovieClip {
		var mc:MovieClip = this.spawnSpecificEnemy(et, 100);
		mc._x = spawnPoint._x;
		mc._y = spawnPoint._y;
		_root.absDelete(spawnPoint);
		return mc;
	},
	
	spawnSpecificEnemy: function (et:Number, initialAlpha:Number):MovieClip {
		duplicateMovieClip("_root.game.BGMid.enemyTemplate" + et, "enemy" + this.enemyIndex, _root.game.BGMid.getNextHighestDepth());
		var mcTmp:MovieClip = eval("_root.game.BGMid.enemy" + this.enemyIndex);
		//var mcTmp = eval("_root.game.BGMid.enemy" + this.enemyIndex);
		
		this.enemyIndex++;
		_root.fcEnemies.registerEnemy(mcTmp);
		if (et == 14 || et == 0) { 
			mcTmp._y = _root.GROUND_ENEMY_Y;
		} else if (et == 3) {
			mcTmp._y = 30;
		}
		else {
			mcTmp._y = random(400) + 10;
		}
		teleportIn(mcTmp);
		mcTmp._alpha = initialAlpha;
		mcTmp.xScaleFactor = 1;
		return mcTmp;
	},
	
	teleportIn: function(o:MovieClip):Void {
		o._alpha = 0;
		o._x = _root.game.hero._x - _root.game.BGMid._x
			+ (2 * random(_root.lLevelWidthMid))
			- _root.lLevelWidthMid
		;
	}
}