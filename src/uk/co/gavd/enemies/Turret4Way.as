package uk.co.gavd.enemies {
    public class Turret4Way extends Turret {
        
        private var hp:Number = 17;
        private var scoreForKill:Number = 20;
        private var rateOfFire:Number = 110;
        
        private static var FIRE_DISTANCE:Number = 500;
        
        private function doFire (lTargetX:Number, distFromHero:Number):Boolean {
            if(--this.clicksToFire <= 0) {
                this.clicksToFire = this.rateOfFire;
            } else {
                return false;
            }
            //theRoot.sfx.gotoAndPlay("enemyFireTurret" + this.fireType); // TODO bomber fire
            
            this.getNextBullet().fireAtPoint(this.x, this.y - FIRE_DISTANCE );
            this.getNextBullet().fireAtPoint(this.x, this.y + FIRE_DISTANCE );
            this.getNextBullet().fireAtPoint(this.x + FIRE_DISTANCE, this.y );
            this.getNextBullet().fireAtPoint(this.x - FIRE_DISTANCE, this.y );
            
            return true;
        }
    }
}