class uk.co.gavd.ballistics.Bullet extends MovieClip {
	
	private var framesToLive:Number = 10000;
	public var triggered:Boolean = false;
	
	private var xTravel:Number = 0;
	private var yTravel:Number = 0;
	public var targetX:Number = 0; // TODO lock down?
	public var targetY:Number = 0; // TODO lock down?
	
	private var lSpeed:Number = 5;
	
	private var fired:Boolean = false;
	
	private var damage:Number = 5;
	
	public function fire(targetX:Number, targetY:Number):Void {
		this.targetOn(targetX, targetY);
		
		// calculate remaining distance to the point item is moving to
		var xRem:Number = (this.targetX - this._x);
		var yRem:Number = (this.targetY - this._y);
		
		this.calculateTravelPerFrame(xRem, yRem);
		this.calculateFramesToLive(xRem, yRem);
		
		this.fired = true;
	}
	
	private function targetOn(targetX:Number, targetY:Number) {
		this.targetX = targetX;
		this.targetY = targetY;
	}
	
	private function calculateTravelPerFrame(xRem:Number, yRem:Number):Void {
		// calculate speed of movement per frame
		this.xTravel = this.lSpeed * (Math.abs(xRem) / (Math.abs(xRem) + Math.abs(yRem)));
		this.yTravel = this.lSpeed - xTravel;
	}
	
	private function calculateFramesToLive(xRem:Number, yRem:Number):Void {
		// work out how long this bullet has to live
		var DEFAULT_TTL:Number = 600;
		var ticksToOutOfY:Number = DEFAULT_TTL;
		
		// x/y switchover - TODO any way around this?
		if (targetX < _x) { xTravel *= -1; }
		if (targetY < _y) {
			ticksToOutOfY = (_y + 50) / yTravel;
			yTravel *= -1;
		} else if (targetY > _y) {
			ticksToOutOfY = ((Stage.height + 50) - _y) / yTravel;
		}
		
		var xTicks:Number = (xRem == 0) ? DEFAULT_TTL : Math.round(xRem / xTravel);
		var yTicks:Number = (yRem == 0) ? DEFAULT_TTL : Math.round(yRem / yTravel);		
		
		trace("x ticks are " + xTicks + "; y ticks are " + yTicks);
		
		framesToLive = (xTicks < yTicks) ? xTicks : yTicks;
		framesToLive = (ticksToOutOfY < framesToLive) ? ticksToOutOfY : framesToLive;
		
		trace("Final ticks are " + framesToLive);
	}
	
	private function moveTowardsTarget():Void {
		
		this._x += this.xTravel;
		this._y += this.yTravel;
			
		if (--this.framesToLive < 0) {
			if(!this.triggered) {
				this.triggered = true;
				trace("OK so explode " + this);
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