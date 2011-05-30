 // TODO the inverter fails if enemy killed on that frame
var score:Number = 0;
var enemyTypes:Number = 0;
while (eval("_root.game.BGMid.enemyTemplate" + enemyTypes)) {
	++enemyTypes;
}
trace("THERE ARE " + enemyTypes + " spawnable enemy types");

var debugMode:Boolean = true;
var ANGLED_SHOTS:Boolean = true;
var rollingScrolling:Boolean = false;		// "false" for conventional shooter
var SCROLL_SPEED:Number = 1;

// Hero details
var lHeroBulletSpeed:Number = 32;
var lHeroPulseFireAmount:Number = 20;		// how much is discharged by a pulse cannon blast
var lGravityPull:Number = 0.02;				// number of pixels the Y inertia is incremented by per frame
var GROUND_ENEMY_Y:Number = 475;
var SCROLL_BOUNDS_Y_UPPER:Number =  22;
var SCROLL_BOUNDS_Y_LOWER:Number =  470;

// Game details
var lLevelWidthMid:Number = 760;//1520;			// number of pixels the mid level is wide

// Enemy details
var lBulletSpeed:Number = 14;				// pixels a bullet travels per frame
// NOTE - bullet speed and damage can be set per bullet type also
var lBulletFireDistance:Number = 800;		// how many pixels a shot travels along its trajectory
var lBulletDamage:Number = 10;				// how much power an enemy bullet has
var lEnemyFireRange:Number = 300;	// just a default, some enemies do their own thing
var initialFramesBetweenEnemySpawn:Number = 50;
var framesBetweenEnemySpawn:Number = initialFramesBetweenEnemySpawn;
var minFramesBetweenEnemySpawn:Number = 15;
var maxEnemies:Number = 40;