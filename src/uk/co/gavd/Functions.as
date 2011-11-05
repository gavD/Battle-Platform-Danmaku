// TODO manage deletes properly
function absDelete(item:MovieClip):void {
    //item.swapDepths(0);
    //item.removeMovieClip();
    if(item) {
        item = null; // TODO check this, is it gone?
    }
}
function restart():void {
    // TODO
    score = 0;
// TODO    game.hero.init(true);
    
    // reset music if necessary
    theRoot.sfxMusic.gotoAndPlay("maybeInMay");
    bGamePaused = false;
    theRoot.fcBullets.killAll = false;
    trace("RESTART");
    theRoot.fcGameOver.gotoAndStop(1);
    theRoot.fcGameOver._visible = false;
}

function distanceBetween(clip1:MovieClip,clip2:MovieClip):Number {
    var xd:Number = (clip1.x-clip2.x);
    var yd:Number = (clip1.y-clip2.y);
    return (Math.sqrt(xd*xd + yd*yd));
}