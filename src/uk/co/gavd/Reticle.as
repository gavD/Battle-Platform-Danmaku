class uk.co.gavd.Reticle extends MovieClip {
	var lShotIndex:Number = 0;
	var lMuzzleIndex:Number = 0;
	var isMouseDown:Boolean = false;
	var framesBetweenShots:Number = 7;
	var clicksToNextShot:Number = 0;
	
	function fireShot(directional:Boolean):Void {
		
		if(directional == undefined) {
			directional = false;
		}
		
		//trace("Fire shot");
		if (_root.bGamePaused) {
			trace("GAME PAUSED - CAN'T FIRE");
			return;
		} else if (_root.game.hero.lAction != _root.game.hero.OK) {
			trace("HERO NOT OK - CAN'T FIRE");
			return;
		}
		
		// fire a bullet
		lShotIndex++;
		var tmp:String = "bulletHero" + lShotIndex;
		var d:Number = _root.game.BGMid.getNextHighestDepth();
		var mcTmp:MovieClip = _root.game.BGMid.bulletHero.duplicateMovieClip(tmp, d);
		//duplicateMovieClip("_root.game.BGMid.bulletHero", tmp, d);
		//eval("_root.game.BGMid.bulletHero" + lShotIndex);
		mcTmp._x = _root.game.hero._x - _root.game.BGMid._x + (_root.game.hero.facingRight ? 5 : -5);
		mcTmp._y = _root.game.hero._y - 12;
//		_root.fcBullets.regBullet(mcTmp);

		if(_root.ANGLED_SHOTS && directional) {
			var virtualCursorX:Number = this._x - _root.game._x - _root.game.BGMid._x;
			mcTmp.fire(virtualCursorX, this._y);
			//_root.fcBullets.targetObjectOnDirection(mcTmp, virtualCursorX, this._y);
			// TODO pull into bullet?
			var myRadians:Number = Math.atan2( mcTmp._y - mcTmp.targetY, mcTmp._x - mcTmp.targetX );
			mcTmp._rotation = (myRadians * (180 / Math.PI)) + 180;
		} else { // straight line fire
			mcTmp.fire(mcTmp._x + _root.lBulletFireDistance * (_root.game.hero.facingRight ? 1 : -1),
						mcTmp._y);
			if(!_root.game.hero.facingRight) {
				mcTmp._rotation = 180;
			}
		}
		_root.game.hero.lPulseAmmo -= _root.lHeroPulseFireAmount;
		//_root.game.hero.shot.gotoAndPlay("start");

		var muzzle:MovieClip = _root.game.BGMid.muzzleHero.duplicateMovieClip("muzzleHero" + lMuzzleIndex, _root.game.BGMid.getNextHighestDepth());
		//eval("_root.game.BGMid.muzzleHero" + lMuzzleIndex++);
		muzzle._x = mcTmp._x;
		muzzle._y = mcTmp._y;
		if(!_root.game.hero.facingRight) {
			muzzle._rotation = 180;
		}
		muzzle.gotoAndPlay(2);
	}
	
	function onMouseDown() {
		this.isMouseDown = true;
	}
	function onMouseUp() {
		this.clicksToNextShot = 0;
		this.isMouseDown = false;
	}
	
	function onEnterFrame() {
		this._x = _root._xmouse;
		this._y = _root._ymouse;
		if(this.isMouseDown) {
			if(--this.clicksToNextShot <= 0) {
				this.fireShot(true);
				this.clicksToNextShot = this.framesBetweenShots;
			}
		}	
	}
}