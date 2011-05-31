var fcEnemies:Object = {

	scoreIndex: 0,
	arEnemies: new Array(),
	
	killAll: function():Void {
		_root.fcGameOver.readyForRestart = true;
		trace("*** REMOVE ALL AMMO " + _root.fcBullets); 
		_root.fcBullets.killAll = true;
		for(var i:Number = 0; i < this.arEnemies.length; i++) {
			var tmp = this.arEnemies[i];
			trace("KILL ENEMY " + tmp);
			_root.absDelete(tmp);
		}
		this.arEnemies = new Array();
	},
	
	registerEnemy: function (ptr:Enemy):Void {
		// let's see if we can put it in an existing place
		var spaceFound:Boolean = false;
		for(var i:Number = 0; i < this.arEnemies.length; i++) {
			if (this.arEnemies[i]._x == undefined) {
				trace("Put in at " + i);
				this.arEnemies[i] = ptr;
				spaceFound = true;
				break;
			}
		}
		// chuck it on the end of the array
		if (!spaceFound) {
			if (this.arEnemies.length >= _root.maxEnemies) {
				trace("ALREADY HAVE " + _root.maxEnemies + " enemies, BLAMMING");
				_root.absDelete(ptr);
			} else {
				this.arEnemies.push(ptr);
			}
		}
	},
	
	detectHits: function(bullet:MovieClip):Void {
		for (var i:Number = 0; i < this.arEnemies.length; i++) {
			var ptr:MovieClip = this.arEnemies[i];
		
			/*
			if (ptr == null) {
				trace("## NULL at " + i);
				continue;
			}
			else */
			if (ptr._x == undefined) { 
				continue;
			}
			else if (ptr.lAction == Enemy.DYING) {
				continue;
			}
			
			//trace("Hit zone test on " + bullet.hitZone + " vs " + ptr);
			if (bullet.hitZone.hitTest(ptr)) {
				_root.hud.mobileHud.scoreCounter.comboMeter.comboUp();
				bullet.gotoAndPlay("explode");
				bullet.triggered = true;
				if(ptr.takeHit) {
					ptr.takeHit();
				} else {
					this.kill(ptr);
				}
			}
		}
	},
	
	kill: function(ptr:MovieClip):Void {
		ptr.lAction = Enemy.DYING;
		var scoreUp:Number = (ptr.scoreForKill * _root.hud.mobileHud.scoreCounter.comboMeter.multiplier);
		_root.score += scoreUp;
		var mcTmp:MovieClip = _root.game.BGMid.scoreFloaterTemplate.duplicateMovieClip("score" + this.scoreIndex, _root.game.BGMid.getNextHighestDepth());
		//var mcTmp:MovieClip = eval("_root.game.BGMid.score" + this.scoreIndex);
		this.scoreIndex++; // TODO can remove?
		mcTmp._x = ptr._x;
		mcTmp._y = ptr._y;
		mcTmp.score = scoreUp;
		ptr.gotoAndPlay("die");
	},
	

	moveAll: function (amt:Number):Void {
trace(" *** MOVEALL ***");
		for (var i:Number = 0; i < this.arEnemies.length; i++) {
			var ptr:MovieClip = this.arEnemies[i];
		
			if (ptr == null) { continue; }
			else if (ptr._x == undefined) { continue; }
//			trace(i + " :: " + ptr + " " + getDistanceFromHero(ptr) + " hero x is " + _root.game.hero._x) ;
			
			ptr._x += amt;
			var dist:Number = this.getDistanceFromHeroRaw(ptr);
			var absDist:Number = Math.abs(dist);
			// OK now let's check for anything that fell a long way behind
			// we only do this if the distance from the hero is greater than one
			// screen width to prevent enemies "jumping"
			
			if (absDist > 12000) {
				trace("Emergency port"); 
				_root.enemyGenerator.teleportIn(ptr);
			} else if (absDist > _root.lLevelWidthMid) { //(_root.lLevelWidthMid/2)) {
				trace("Dist is " + dist);
				
				if (dist > 0) {
					ptr._x += 3 * _root.lLevelWidthMid;
				} else {
					ptr._x += -3 * _root.lLevelWidthMid;
				
				}
			}
		}
	},
	
	getDistanceFromHeroRaw: function (ptr:MovieClip):Number {
		return (_root.game.hero._x - _root.game.BGMid._x) - ptr._x
	},
	
	getDistanceFromHero: function (ptr:MovieClip):Number {
		return Math.abs(this.getDistanceFromHeroRaw(ptr));
	},
	
	applyBounceInner: function (enemy:MovieClip, bounceScaleFactor:Number):Void {
		var heroX:Number = _root.game.hero._x - _root.game.BGMid._x;
		
		var inertia:Number = 9 * bounceScaleFactor;
		var inertiaXMod:Number = 0;
		var inertiaYMod:Number = 0;
		
		if (heroX < enemy._x) {
			inertiaXMod = inertia;
		} else if (heroX > enemy._x) {
			inertiaXMod = inertia * -1;
		}
		
		if (_root.game.hero._y < enemy._y) {
			inertiaYMod = inertia * -1;
		} else if (_root.game.hero._y > enemy._y) {
			inertiaYMod = inertia;
		}
		//trace("Apply bounce inner " + enemy + ":" + inertiaXMod + ";" + inertiaYMod);
		
		_root.game.hero.lInertiaX += inertiaXMod;
		_root.game.hero.lInertiaY += inertiaYMod;		
	},
	
	applyBounce: function (enemy:MovieClip, bounceScaleFactor:Number):Void {
		var heroX:Number = _root.game.hero._x - _root.game.BGMid._x;
		if (Math.abs(heroX - enemy._x) < (enemy._width / 2)
		 && Math.abs(_root.game.hero._y - enemy._y) < (enemy._height / 2))
		{
			this.applyBounceInner(enemy, bounceScaleFactor);
		}
	},
	
	doFrame: function():Void {
		if (_root.bGamePaused) { return; }
		
		for (var i:Number = 0; i < this.arEnemies.length; i++) {
			var tmp:MovieClip = this.arEnemies[i];

			if(this.arEnemies[i]._x == undefined) {
				continue;
			}
			this.arEnemies[i].process();
			this.applyBounce(this.arEnemies[i], this.arEnemies[i].xScaleFactor);
		}
		_root.fcBullets.killAll = false; // TODO?
	}
}