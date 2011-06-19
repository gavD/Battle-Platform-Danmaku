 // TODO the inverter fails if enemy killed on that frame
var score:Number = 0;
var debugMode:Boolean = true;
var ANGLED_SHOTS:Boolean = true;
var rollingScrolling:Boolean = false;		// "false" for conventional shooter
var SCROLL_SPEED:Number = 1;

// Hero details
var lHeroPulseFireAmount:Number = 20;		// how much is discharged by a pulse cannon blast
var GROUND_ENEMY_Y:Number = 475;
var SCROLL_BOUNDS_Y_UPPER:Number =  22;
var SCROLL_BOUNDS_Y_LOWER:Number =  470;

// Game details
var lLevelWidthMid:Number = 760;//1520;			// number of pixels the mid level is wide


var initialFramesBetweenEnemySpawn:Number = 50;
var framesBetweenEnemySpawn:Number = initialFramesBetweenEnemySpawn;
var minFramesBetweenEnemySpawn:Number = 15;
var maxEnemies:Number = 50;