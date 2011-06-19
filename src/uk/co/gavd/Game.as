class uk.co.gavd.Game extends MovieClip {
	private var flipScreenAmount:Number = 250; // number of pixels to scroll right by when facing left
	private var flipScreenSpeed:Number = 15;
	
//	private var initBGMidX:Number = this.BGMid._x;
	private var initBGTiles:Number = 0;
	private var curLevel:Number = 0;
	private var BGTiles:MovieClip;
	private var BGMid:MovieClip;
	private var hero:MovieClip;
	
	public function onLoad() {
		this.BGTiles = this['BGTiles']; // TODO better way?
		this.BGMid = this['BGMid']; // TODO better way?
		this.hero = this['hero'];
		
		this.initBGTiles = this.BGTiles._x;
		this.loadLevel(1);
	}
	
	public function loadLevel(level:Number):Void {
		this.curLevel = level;
		this._x = 0;
		this._y = 0;	// Put the game in position. this means it's easier to edit without worrying about getting it out of position
		this.BGMid._x = 0; //initBGMidX;
		this.BGMid.gotoAndStop(level);
		this.BGTiles._x = initBGTiles;
		this.BGTiles.gotoAndStop(level);
		
		if (level > 1) {
			_root.fcEnemies.killAll();
		}
	}
	
	
	function onEnterFrame() {
		if(_root.bGamePaused) {
			return;
		}
		/*
		// no more rollin scrollin
		// rolling scrolling
		if (this.BGMid._x < (-1 * _root.lLevelWidthMid)) {
			trace("Moved everything right");
			this.BGMid._x += _root.lLevelWidthMid;
			_root.fcEnemies.moveAll(_root.lLevelWidthMid * -1);
			_root.fcBullets.moveAll(_root.lLevelWidthMid * -1);
		}
		else if (this.BGMid._x > 0) {
			trace("Moved everything left");
			this.BGMid._x -= _root.lLevelWidthMid;
			_root.fcEnemies.moveAll(_root.lLevelWidthMid);
			_root.fcBullets.moveAll(_root.lLevelWidthMid);
		}
		*/
		if(_root.rollingScrolling) {
			if (hero.facingRight) {
				if (this._x > 0) {
					this._x -= flipScreenSpeed;
				}
			}
			else if (this._x < flipScreenAmount) {
				this._x += flipScreenSpeed;
			}
		} else {
			this.BGMid._x -= _root.SCROLL_SPEED;
			if(this.curLevel == 1 && this.BGMid._x < -4750) {
				trace("LEVEL UP"); // TODO tidy this up
				this.loadLevel(2);
			}
			this.BGTiles._x -= _root.SCROLL_SPEED * 0.2;
			//this.hero._x+= _root.SCROLL_SPEED;
		}
	}
}