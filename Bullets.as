var fcBullets:Object = {
	
	killAll: false,
	arBullets: new Array(),
	bulPtr: 0,
	
	moveAll: function(amt:Number):Void {
		for (var i = 0; i < this.arBullets.length; i++) {
			if(this.arBullets[i] instanceof MovieClip) {
				this.arBullets[i]._x += amt;
				this.arBullets[i].lTargetX += amt;
			}
		}
	},
	
	handleBullet: function(bul:MovieClip):Void {
		if (this.killAll) {
			_root.absDelete(bul);
		}
		this.moveItemTowards(bul, bul.lTargetX, bul.lTargetY, bul.lSpeed);
		if (!bul.triggered && bul.hitTest(_root.game.hero.hitZone)) {
			_root.game.hero.takeHit(bul.bulletDamage);
			_root.fcEnemies.applyBounceInner(bul, 1);
			bul.gotoAndPlay("explode");
			this.count--; // TODO remove count
		}
	},
	
	targetObjectOnPoint: function (mcTmp:MovieClip, tX:Number, tY:Number): Void {
		var myRadians:Number = Math.atan2(mcTmp._y - tY, tX - mcTmp._x);
		myRadians += Math.PI/2; // rotate round 90' - needs that for some reason
		mcTmp.lTargetX = mcTmp._x + Math.sin(myRadians) * _root.lBulletFireDistance;
		mcTmp.lTargetY = mcTmp._y + Math.cos(myRadians) * _root.lBulletFireDistance;
	},
	
	moveItemTowards: function (item:MovieClip, targetX:Number,targetY:Number, speed:Number):Void {
		if(item.triggered) {
			item.lSpeed /= 2;
		}
		
		if (_root.bGamePaused) { return; } 

		var stopChar:Boolean = true;
		// calculate remaining distance to the point item is moving to
		var xRem:Number = (targetX - item._x);
		var yRem:Number = (targetY - item._y);

		// calculate the distances to go in each direction as a proportion
		// of the total walk distance as defined in the root
		var xTravel:Number = speed * (Math.abs(xRem) / (Math.abs(xRem) + Math.abs(yRem)));
		var yTravel:Number = speed - xTravel;

		// move the item
		if (Math.abs(xRem) > speed) {
			if (item._x > targetX) {
				item._x -= xTravel;
			} else {
				item._x += xTravel;
			}
			stopChar = false;
		}
		if (Math.abs(yRem) > speed) {
			if (item._y > targetY) {
				item._y -= yTravel;
			} else {
				item._y += yTravel;
			}
			stopChar = false;
		}
		if (stopChar) {
			if(!item.triggered) {
				item.triggered = true;
				item.gotoAndPlay("explode");
				this.count--; // TODO remove
			}
		}
	}
}