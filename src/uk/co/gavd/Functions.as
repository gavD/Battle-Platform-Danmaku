function absDelete(item:MovieClip):Void {
	item.swapDepths(0);
	item.removeMovieClip();
	if(item) {
		// TODO necessary?
		removeMovieClip (item);
	}
}
function restart():Void {
	// TODO
	score = 0;
	game.hero.init(true);
	
	// reset music if necessary
	_root.sfxMusic.gotoAndPlay("maybeInMay");
	framesBetweenEnemySpawn = initialFramesBetweenEnemySpawn;
	bGamePaused = false;
	_root.fcBullets.killAll = false;
	trace("RESTART");
	_root.fcGameOver.gotoAndStop(1);
	_root.fcGameOver._visible = false;
}

function distanceBetween(clip1:MovieClip,clip2:MovieClip):Number {
	var xd:Number = (clip1._x-clip2._x);
	var yd:Number = (clip1._y-clip2._y);
	return (Math.sqrt(xd*xd + yd*yd));
}