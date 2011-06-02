class uk.co.gavd.Hero extends MovieClip {
	public var power:Number = 1;
	
	private var lAction:Number = OK;
	private var OK:Number = 0;
	private var DYING:Number = 1;

	private var bInvincible:Boolean = false;
	
	// ************* //
	private var lMaxEnergy:Number = 40; // 1000; //90 + (_root.debugMode ? 1000 : 0); // 100;
		
	private var lInertiaX:Number = 0;
	private var lInertiaY:Number = 0;
	private var inertiaLimit:Number = 5;
	private var lTotalMvt:Number = 0;

	public var lEnergy:Number = 0;

	// inertia and speed
	private var lRatioVertical:Number = 0.2;
	private var slowDownRatio:Number = 1.2; // used in inertia
	private var lEngineSpeedIncrement:Number = 0.8;
	private var oppositeRatio:Number = 2; // if you move in the opposite direction to current
								  // inertia, how much should movement be modified by
		
	public var facingRight:Boolean = true;
	
	public function applyMovement(lXDir:Number, lYDir:Number):Void {
		if (_root.bGamePaused) {return;}
		
		this["thrusterRear"]._visible = false;
		this["thrusterFront"]._visible = false;
		this["thrusterTop"]._visible = false;
		this["thrusterBottom"]._visible = false;
		if (lXDir > 0) {
			this["thrusterFront"]._visible = true;
		} else if (lXDir < 0) {
			this["thrusterRear"]._visible = true;
		}
		if (lYDir > 0) {
			this["thrusterTop"]._visible = true;
		} else if (lYDir < 0) {
			this["thrusterBottom"]._visible = true;
		}

//		trace("lXDir = " + lXDir);
		
//		applyMovementDirection(lXDir);
		  
		if (lXDir == 0) { // neutral
			if (lInertiaX > 0) {
				lInertiaX -= lEngineSpeedIncrement * slowDownRatio;
				if (lInertiaX < lEngineSpeedIncrement) {
					lInertiaX = 0;
				}
			} else if (lInertiaX < 0) {
				lInertiaX += lEngineSpeedIncrement * slowDownRatio;
				if (lInertiaX > (-lEngineSpeedIncrement)) {
					lInertiaX = 0;
				}
			}
		} else if (lXDir > 0) { // pressingright
			if (lInertiaX < 0) { // double duty
				lInertiaX += lEngineSpeedIncrement * slowDownRatio * oppositeRatio;
			}
			lInertiaX += lEngineSpeedIncrement;
		} else { // pressing left
			if (lInertiaX > 0) { // double duty
				lInertiaX -= lEngineSpeedIncrement * slowDownRatio * oppositeRatio;
			}
			lInertiaX -= lEngineSpeedIncrement;
		}
		
		// scrolling management
		if (lInertiaX != 0)
		{
			if(_root.rollingScrolling) {
				_parent.BGMid._x  += lInertiaX;
				_parent.BGTiles._x  += lInertiaX * 0.5;
			} else {
				
				if (lInertiaX > 0 && this._x < 10) {
					lInertiaX = 0;
				} else if (lInertiaX < 0 && this._x > 700) {
					lInertiaX = 0;
				} else {
					// cap the limits
					if (lInertiaX > inertiaLimit) {
						lInertiaX = inertiaLimit;
						//trace("CAP HIT");
					} else if (lInertiaX < -inertiaLimit) {
						lInertiaX = -inertiaLimit;
						//trace("CAP HIT");
					}
					this._x -= lInertiaX;
				}
			}
		}

//		trace(lInertiaX);
		this._rotation = -lInertiaX;

		if (lYDir > 0) {		// going down
			if (lInertiaY < 0) { // double duty
				lInertiaY += lEngineSpeedIncrement * slowDownRatio * oppositeRatio;
			}
			lInertiaY += (lEngineSpeedIncrement * lRatioVertical);
		} else if (lYDir < 0) {  // going up
			if (lInertiaY > 0) { // double duty
				lInertiaY -= lEngineSpeedIncrement * slowDownRatio * oppositeRatio;
			}
			lInertiaY -= (lEngineSpeedIncrement * lRatioVertical);
		} else { // neutral
			if (lInertiaY > 0) {
				lInertiaY -= lEngineSpeedIncrement * slowDownRatio * lRatioVertical;
			} else if (lInertiaY < 0) {
				lInertiaY += lEngineSpeedIncrement * slowDownRatio * lRatioVertical;
			}
		}
		

		if (
			(lInertiaY < 0 && (this._y < _root.SCROLL_BOUNDS_Y_UPPER))
			||
			(lInertiaY > 0 && (this._y > _root.SCROLL_BOUNDS_Y_LOWER))
			)
		{
			lInertiaY = 0;
		} else {
			// cap the limits
			if (lInertiaY > inertiaLimit) {
				lInertiaY = inertiaLimit;
				//trace("CAP HIT");
			} else if (lInertiaY < -inertiaLimit) {
				lInertiaY = -inertiaLimit;
				//trace("CAP HIT");
			}

			//trace("Inertia : " + lInertiaX + "," + lInertiaY);
			this._y += lInertiaY;
			if (this._y > _root.SCROLL_BOUNDS_Y_LOWER) {
				this._y = _root.SCROLL_BOUNDS_Y_LOWER;
				lInertiaY = 0;
			}
		}		
	}
	
	public function reset():Void {
		trace("*************RESET****************");
		_root.game._rotation = 0;
		
		_root.bGamePaused = true;
		_root.fcGameOver._visible = true;
		_root.fcGameOver.play();
	}
	
	public function init(bInvincibleThis:Boolean):Void {
		this._visible = true;
		lInertiaX = 0;
		lInertiaY = 0;
		this.lEnergy = this.lMaxEnergy;
		
		this.lAction = OK;
		this._x = 250;
		this._y = 180;
		bInvincible = bInvincibleThis;
		if (bInvincible) {
			_root.fcBlinker.doInvincible();
		}
	}

	public function takeHit(lDamage:Number):Void {
		if (lAction == DYING) {
			return;
		} else if (bInvincible && lDamage < 1500) {
			return;
		}
		
		_root.takeHit.gotoAndPlay(2);
		
		_root.fcBlinker.gotoAndStop(1);
		this._visible = true;
		lEnergy -= lDamage;
		
		if (lEnergy <= 0) {
			lAction = DYING;
			gotoAndPlay("die");
		} else {
			this.gotoAndPlay("takeHit");
			_root.sfxEnemyExplosions.gotoAndPlay("heroTakeHit");
		}
		
	}
	
	function onLoad() {
		this.init(true);	
	}
	
	function onEnterFrame() {
		if (_root.bGamePaused) { return; }
		else if (lAction == DYING) { return; }
		
		var lXDir:Number = 0;
		var lYDir:Number = 0;
		
	 // 87 w
	 // 65 a
	 // 83 s
	 // 68 d
		
		if (Key.isDown(Key.RIGHT) || Key.isDown(68)) {
			lXDir = -1;
			if (!facingRight) {
				this.facingRight = true;
				this._xscale = 100;
			}
		} else if (Key.isDown(Key.LEFT) || Key.isDown(65)) {
			lXDir = 1;
			if (_root.rollingScrolling && this.facingRight) {
				this.facingRight = false;
				this._xscale = -100;
			}
		}
		if (Key.isDown(Key.UP) || Key.isDown(87)) {
			lYDir = -1;
		} else if (Key.isDown(Key.DOWN) || Key.isDown(83)) {
			lYDir = 1;
		}
		applyMovement(lXDir,lYDir);
	}

}