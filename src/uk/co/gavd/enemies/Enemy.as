import uk.co.gavd.ballistics.Bullet;

class uk.co.gavd.enemies.Enemy extends MovieClip {

	private static var lBulletIndex:Number = 0; // TODO move to bullets?

	// TODO refactor sof
	private var prefDistToHero:Number = 120;
	private var shotOffset:Number = 0; // adjust where the bullet spawns from
	private var scoreForKill:Number = 5;
	private var fireRange:Number = 300;
	
	private var enemyFadeInRate:Number = 10;
	private var prefYFromHero:Number = 20; // how far a clip should try to get in line with the hero
	
	// ammo types
	private static var AIMATHERO:Number =  0;
	private static var BOMB:Number =  1;
	private static var FOUR_WAY:Number =  2;
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
		
		var targetX:Number  = _root.game.hero._x - _root.game.BGMid._x;
		
		this.turnAndFace(targetX);
		this.handleFiring(targetX);
		this.handleMovementX(targetX);
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
	
	private function turnAndFace(targetX:Number):Void {
		if (this.bFacingLeft && targetX > this._x) {
			this.bFacingLeft = false;
			this._xscale = -100;
		} else if (!this.bFacingLeft && targetX < this._x) {
			this.bFacingLeft = true;
			this._xscale = 100;
		}
	}
	
	private function handleFiring(targetX:Number):Void {
		var distFromHero:Number = targetX - this._x;
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
					if (targetX < this._x) {
						this._x+=this.speed;
					} else {
						this._x-=this.speed;
					}
				}
			}
			*/
			if(this.doFire(targetX, distFromHero)) {
				this.muzzleFlash();
			}
		}
	}
	
	private function handleMovementX(targetX:Number):Void { 
	/*
		if (this.enemyType == this.BOMBER) {
			this._x -= this.speed;
		}
		else if (this.enemyType == this.GROUND_WALK_RIGHT) {
			this._x += this.speed;
		}
		else {
			if (targetX < this._x) {
				this._x-=this.speed;
			} else {
				this._x+=this.speed;
			}
		}
		*/
	}
	
	private function doFire (targetX:Number, distFromHero:Number):Boolean {
		return false;
	}
	
	private function getNextBullet():Bullet {
		var clip:Bullet = _root.game.BGMid.bulletEnemy.duplicateMovieClip("bulletEnemy_" + ++Enemy.lBulletIndex, _root.game.BGMid.getNextHighestDepth());
		clip._x = this._x; // TODO offsetting?
		clip._y = this._y; // TODO offsetting?
		return clip;
	}
		
	private function muzzleFlash():Void {
		var flasher:MovieClip = _root.game.BGMid.flasher0.duplicateMovieClip("bulletEnemy_" + ++Enemy.lBulletIndex, _root.game.BGMid.getNextHighestDepth());
		
		flasher._x = this._x;
		flasher._y = this._y;
	}
	
	private function loadHook():Void {
		// for extensibility
	}
	
	function onLoad():Void {
		this.loadHook();
		this.stop();
		
	}
	
	
}