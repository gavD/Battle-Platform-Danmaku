class uk.co.gavd.ballistics.Bullet extends MovieClip {
	
	// dynamically calculated stuff
	private var fired:Boolean = false;
	public var triggered:Boolean = false;
	private var framesToLive:Number = 10000;
	private var xTravel:Number = 0;
	private var yTravel:Number = 0;
	public var targetX:Number = 0; // TODO lock down?
	public var targetY:Number = 0; // TODO lock down?
	
	// info about this bullet
	private var lSpeed:Number = 5;
	private var damage:Number = 5;
	private var travel:Number = 750; // how many px this bullet can fly
	
	public function fireAtPoint(targetX:Number, targetY:Number):Void {
		this.targetX = targetX ; this.targetY = targetY;// TODO remove
		var angle:Number = this.getAngleTo(targetX, targetY);
		
		var opp:Number = Math.sin(angle) * travel; // opp = h * s
		var adj:Number = Math.cos(angle) * travel; // adj = h * c
		
		this.calculateTravelPerFrame(adj, opp);
		this.calculateFramesToLive(adj, opp);
		
		this.fired = true;
	}
	
	public function fireAtAngle(degrees:Number):Void {
		var radians:Number = degrees * Math.PI / 180;
		var opp:Number = Math.sin(radians) * travel; // opp = h * s
		var adj:Number = Math.cos(radians) * travel; // adj = h * c
		this.fireAtPoint(this._x + opp, this._y + adj);
	}
	
	public function fireAtTarget(target:MovieClip):Void {
		this.fireAtPoint(target._x - _root.game.BGMid._x, target._y);
	}
	
	private function getAngleTo(x2:Number, y2:Number):Number {
		return Math.atan2(y2 - this._y, x2 - this._x);
	}
	
	private function calculateTravelPerFrame(xRem:Number, yRem:Number):Void {
		// calculate speed of movement per frame
		this.xTravel = this.lSpeed * (xRem / (Math.abs(xRem) + Math.abs(yRem)));
		this.yTravel = this.lSpeed - Math.abs(xTravel);
	}
	
	private function calculateFramesToLive(xRem:Number, yRem:Number):Void {
		// work out how long this bullet has to live
		var defaultFramesToLive:Number = Math.round(this.travel / this.lSpeed);
		var ticksToOutOfY:Number = defaultFramesToLive;

		if (targetY < _y) {
			ticksToOutOfY = (_y + 50) / yTravel;
			this.yTravel *= -1;
		} else if (targetY > _y) {
			ticksToOutOfY = ((Stage.height + 50) - _y) / yTravel;
		}
		
		this.framesToLive = (ticksToOutOfY < defaultFramesToLive) ? ticksToOutOfY : defaultFramesToLive;
		
		//trace("ticksToOutOfY=" + ticksToOutOfY + ", default=" + Math.round(this.travel / this.lSpeed) + " : Final ticks are " + framesToLive);
	}
	
	private function moveTowardsTarget():Void {
		
		this._x += this.xTravel;
		this._y += this.yTravel;

		if (--this.framesToLive <= 0) {
			
			if(!this.triggered) {
				this.triggered = true;
				this.gotoAndPlay("explode");
			}
			this.xTravel /= 2; // slow the bullet
			this.yTravel /= 2; // slow the bullet
		}
	}
	
	public function onEnterFrame():Void {
		if(!this.fired) {
			return;
		}

		this.moveTowardsTarget();
		
		if(this.triggered) {
			return;
		}
		
		this.checkForHits();
		
	}
	
	private function checkForHits():Void {
		// TODO ptr to hero?
		if (this['hitZone'].hitTest(_root.game.hero['hitZone'])) {
			_root.game.hero.takeHit(this.damage);
			//_root.fcEnemies.applyBounceInner(bul, 1); // TODO
			this.gotoAndPlay("explode");
		}
	}
	
	public function onLoad():Void {
		this.stop();
	}
}