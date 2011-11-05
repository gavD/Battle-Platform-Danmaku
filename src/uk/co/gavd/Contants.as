var theRoot:MovieClip = MovieClip(root); // TODO perhaps factor this out entirely
stage.quality = StageQuality.LOW;

// game tweaks
const DEBUG_MODE:Boolean = true;
const ANGLED_SHOTS:Boolean = true;
const SCROLL_SPEED:Number = 1;
const MAX_ENEMIES:Number = 50;

// game boundaries
const SCROLL_BOUNDSy_UPPER:Number =  22;
const SCROLL_BOUNDSy_LOWER:Number =  470;

// global variables
// TODO factor these out into a configuration object
var score:Number = 0;
var bGamePaused:Boolean = false;
var fireReady:Boolean = true;