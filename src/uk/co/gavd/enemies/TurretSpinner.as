package uk.co.gavd.enemies {

import uk.co.gavd.ballistics.Bullet;

    public class TurretSpinner extends Turret  {
    
    private var hp:Number = 10;
    private var scoreForKill:Number = 30;
    private var rateOfFire:Number = 5;
    
    private static var FIRE_DISTANCE:Number = 600;
    
    private function doFire (lTargetX:Number, distFromHero:Number):Boolean {
        if(--this.clicksToFire <= 0) {
            this.clicksToFire = this.rateOfFire;
        } else {
            return false;
        }
        //theRoot.sfx.gotoAndPlay("enemyFireTurret" + this.fireType); // TODO bomber fire
        
        this.getNextBullet().fireAtAngle(this.rotation*-1 );
        //this.getNextBullet().fireAtAngle(this.rotation );
        
        return true;
    }    
    
    private function getNextBullet():Bullet {
        var clip:Bullet = theRoot.game.BGMid.bulletEnemySlow.duplicateMovieClip("bulletEnemy_" + ++Enemy.lBulletIndex, theRoot.game.BGMid.getNextHighestDepth());
        clip.x = this.x; // TODO offsetting?
        clip.y = this.y; // TODO offsetting?
        return clip;
    }
    
    public function onEnterFrame():void {
        this.rotation++;
    }
    }
}