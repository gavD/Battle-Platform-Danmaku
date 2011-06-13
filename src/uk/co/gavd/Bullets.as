// TODO can we shred this?

var fcBullets:Object = {
	
	killAll: false,
//	arBullets: new Array(),
//	bulPtr: 0
	
	
	/*,
		
	handleBullet: function(bul:Bullet):Void {
		trace("Handle bullet " + bul + "...................");
		if (this.killAll) { // TODO need some implementation of killAll?
			_root.absDelete(bul);
		}
		this.moveItemTowards(bul, bul.targetX, bul.targetY, bul.lSpeed);

		
		
	},
	
	targetObjectOnPoint: function (mcTmp:Bullet, tX:Number, tY:Number): Void {
		trace("########## targetObjectOnPoint");
		mcTmp.targetX = tX;
		mcTmp.targetY = tY;
	},
	
	targetObjectOnDirection: function (mcTmp:Bullet, tX:Number, tY:Number): Void {
		trace("########## targetObjectOnDirection");
		var myRadians:Number = Math.atan2(mcTmp._y - tY, tX - mcTmp._x);
		myRadians += Math.PI/2; // rotate round 90' - needs that for some reason
		mcTmp.targetX = mcTmp._x + Math.sin(myRadians) * _root.lBulletFireDistance;
		mcTmp.targetY = mcTmp._y + Math.cos(myRadians) * _root.lBulletFireDistance;
	}
	*/
}