class Enemy extends MovieClip {

	private static var lBulletIndex:Number = 0; // TODO move to bullets?

	// TODO refactor sof
	private var prefDistToHero:Number = 120;
	private var fireType:Number = 0; // TODO _root.fcEnemies.AIMATHERO;
	private var shotOffset:Number = 0; // adjust where the bullet spawns from
	private var scoreForKill:Number = 5;
	private var fireRange:Number = 300;
	
	private var enemyFadeInRate:Number = 10;
	private var prefYFromHero:Number = 20; // how far a clip should try to get in line with the hero
	
	// ammo types
	private static var AIMATHERO:Number =  0;
	private static var BOMB:Number =  1;
	private static var STRAIGHTUP:Number =  2;
	private static var SHOTGUN:Number =  3;
	private static var STRAIGHTACROSS:Number =  4;
	private static var BOMB_VERT:Number =  5; // TODO these 2 are dupes in bg play area
	private static var AMMO_ROTATING:Number =  6;  // TODO these 2 are dupes in bg play area
	private static var CLOUD:Number = 7;
	
	public static var NOTHING:Number = 0;
	public static var HOMING:Number = 1;
	public static var DYING:Number = 3;
	
	// TODO refactor eof
	
	public var lAction:Number = 0;
	public var bFacingLeft:Boolean = true;

	private function process():Void {
		if (_root.game.hero.lAction != 0) {
			//trace("game not in play");
			return;
		}
		if (this._alpha < 100) {
			this._alpha += this.enemyFadeInRate;
			return;
		}

		if (this.lAction == Enemy.DYING) {
			return;
		}
		if (this.lAction == Enemy.NOTHING) { // TODO activation?
			this.lAction = Enemy.HOMING;
		}
		else if (this.lAction == Enemy.HOMING) {
			this.handleMovementAndShooting();
		}
			
	}
	
	private function handleMovementAndShooting():Void {
		this.handleMovementY();
		
		var lTargetX:Number  = _root.game.hero._x - _root.game.BGMid._x;
		
		this.turnAndFace(lTargetX);
		this.handleFiring(lTargetX);
		this.handleMovementX(lTargetX);
		
	}
	
	private function handleMovementY():Void {
		/*
		// TODO move into flying class
		if (this.enemyType == this.FLYING) {
			if (Math.abs(this._y - _root.game.hero._y) > this.prefYFromHero) {
				// default to being OK with being within 20 pixels
				// of the hero on the Y axis
				var desiredYMin:Number = _root.game.hero._y - 10;
				var desiredYMax:Number = desiredYMin + 20;
				
// TODO?			//if (this.prefDistToHeroYMax) {
//						desiredYMin += this.prefDistToHeroYMin;
//						desiredYMax += this.prefDistToHeroYMax;
//					}
				
				if (this._y < desiredYMin) {
					this._y += this.speed;
				} else if (this._y > 10 && this._y > desiredYMax) {
					this._y -= this.speed;
				}
			}
			
			// fix scroll bounds
			if (this._y < _root.SCROLL_BOUNDS_Y_UPPER) {
				this._y = _root.SCROLL_BOUNDS_Y_UPPER;
			} else if (this._y > _root.SCROLL_BOUNDS_Y_LOWER){
				this._y = _root.SCROLL_BOUNDS_Y_LOWER;
			}
		}
		*/
	}
	
	private function turnAndFace(lTargetX:Number):Void {
		if (this.bFacingLeft && lTargetX > this._x) {
			this.bFacingLeft = false;
			this._xscale = -100;
		} else if (!this.bFacingLeft && lTargetX < this._x) {
			this.bFacingLeft = true;
			this._xscale = 100;
		}
	}
	
	private function handleFiring(lTargetX:Number):Void {
		var distFromHero:Number = lTargetX - this._x;
		var lDistX:Number = Math.abs(distFromHero);
		//trace("Dist: " + lDistX + "; range : " +  _root.lEnemyFireRange);
		if (lDistX <= this.fireRange) { // within firing range
			/*
			// bombers and ground movers don't stop
			//trace("CHECK FOR STOP");
			if (this.enemyType == this.BOMBER || this.enemyType == this.GROUND_WALK_RIGHT)   {
				//trace("################DO MOVE");
				doMove = true;
			} else {
				doMove = false;
				if (lDistX < this.prefDistToHero) { // TOO CLOSE
					if (lTargetX < this._x) {
						this._x+=this.speed;
					} else {
						this._x-=this.speed;
					}
				}
			}
			*/
			if(this.doFire(lTargetX, distFromHero)) {
				this.muzzleFlash();
			}
		}
	}
	
	private function handleMovementX(lTargetX:Number):Void { 
	/*
		if (this.enemyType == this.BOMBER) {
			this._x -= this.speed;
		}
		else if (this.enemyType == this.GROUND_WALK_RIGHT) {
			this._x += this.speed;
		}
		else {
			if (lTargetX < this._x) {
				this._x-=this.speed;
			} else {
				this._x+=this.speed;
			}
		}
		*/
	}
	
	// TODO shred most of this
	private function doFire (lTargetX:Number, distFromHero:Number):Boolean {
		return false;
		/*
		var ptr:MovieClip = this; // TODO remove
		_root.sfx.gotoAndPlay("enemyFire" + ptr.fireType); // TODO bomber fire
		
		var mcTmp:MovieClip = this.getNextBullet(ptr._x, ptr._y + ptr.shotOffset, ptr.fireType);
		if (ptr.fireType == this.AMMO_ROTATING) {
			var hyp:Number = 230;
			var rads:Number = ptr.rot * (Math.PI/180);
			switch( ptr.rot) {
				case -90:	mcTmp._y -= 80; break;
				case -45:	mcTmp._x += 60; mcTmp._y -= 60; break;
				case 0:		mcTmp._x += 80; break;
				case 45:	mcTmp._x += 60; mcTmp._y += 60; break;
				case 90:	mcTmp._y += 80; break;
				case 135:	mcTmp._x -= 60; mcTmp._y += 60; break;
				case 180:	mcTmp._x -= 80; break;
				case -135:	mcTmp._x -= 60; mcTmp._y -= 60; break;
			}
			trace("Rot from " + ptr.rot);
			mcTmp.lTargetX = mcTmp._x + hyp * Math.cos(rads);
			mcTmp.lTargetY = mcTmp._y + hyp * Math.sin(rads);
		} 
		else if (ptr.fireType == this.BOMB_VERT)  {
			this.targetBulletOnHero(mcTmp);
			mcTmp.lTargetY = 500;
		}
		else if (ptr.fireType == this.BOMB)  {
			mcTmp.lTargetY = 500;
			mcTmp.lTargetX = ptr._x;
		}
		else if (ptr.fireType == this.STRAIGHTUP) {
			mcTmp.lTargetY = ptr._y - 500;
			mcTmp.lTargetX = ptr._x;
		} else if (ptr.fireType == this.STRAIGHTACROSS) {
			mcTmp.lTargetX = mcTmp._x + (_root.lBulletFireDistance * ((distFromHero > 0) ? 1 : -1));
			mcTmp.lTargetY = mcTmp._y;
			//trace("bullet " + mcTmp + " targets " + mcTmp.lTargetX + "," + mcTmp.lTargetY);
		} else {
			trace("INVALID BULLET TYPE FOR " + ptr);
		}

		this.muzzleFlash();
		*/
	}
	
	private function getNextBullet (sX:Number,sY:Number, fireType:Number):MovieClip {
		var clip:MovieClip = eval("_root.game.BGMid.bulletEnemy" + fireType);
		var mcTmp:MovieClip = clip.duplicateMovieClip("bulletEnemy_" + ++Enemy.lBulletIndex, _root.game.BGMid.getNextHighestDepth());
		mcTmp._x = sX;
		mcTmp._y = sY;
		return mcTmp;
	}
	
	private function targetBulletOnHero (mcTmp:MovieClip):Void {
		_root.fcBullets.targetObjectOnPoint(mcTmp, _root.game.hero._x - _root.game.BGMid._x,  _root.game.hero._y);
	}	
	
	private function muzzleFlash():Void {
		var bulletPrototype:MovieClip = eval("_root.game.BGMid.flasher" + this.fireType);
		var flasher:MovieClip = bulletPrototype.duplicateMovieClip("bulletEnemy_" + ++Enemy.lBulletIndex, _root.game.BGMid.getNextHighestDepth());
		
		flasher._x = this._x;
		flasher._y = this._y;
	}
	
	function onLoad() {
		this.stop();
	}
}