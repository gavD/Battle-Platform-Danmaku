package uk.co.gavd.danmakuengine.enemies {
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.ballistics.*;
	import flash.display.*;
	import flash.events.Event;
	import flash.media.Sound;

    public class Guardian2 extends Turret {
		
		private var gameAffected:Boolean = false;
		private var bulrot:int = 0;
		private var rotrate:int = 1;
		
		public function Guardian2(game:Game) {
			super(game);
			
			this.fireRange = 800;
			this.scoreForKill = 400;
			this.rateOfFire = 9;
			this.hp = 250;
			
			this.fireSound = new BulletGuardian1Wav();
		}
		
		override public function takeHit():void {
			super.takeHit();
			this.x--;
			if(this.hp < 200) {
				rotrate = 2;
			} else if (this.hp < 100) {
				rotrate = 3;
			} else if (this.hp < 5) {
				rotrate = 4;
			}
		}
		
		
		override protected function getOnScreenMin():uint {
			return 670;
		}
		
		override protected function getNewBullet():Bullet {
			return new BulletWhite(game);
		}
		
		override protected function dieHook():void {
			game.startScrolling();
		}
		
		override protected function doFire (lTargetX:Number, distFromHero:Number):Boolean {
			if(!gameAffected) {
				game.stopScrolling();
				gameAffected = true;
			}
			
			if(--this.clicksToFire <= 0) {
				this.clicksToFire = this.rateOfFire;
			} else {
				return false;
			}
			
			if(bulrot > 46) {
				rotrate *= -1;
			} else if (bulrot < 0) {
				rotrate *= -1;
			}
			
			bulrot += rotrate;
			
			
			this.getNextBullet().fireAtAngle(0 + bulrot);
			this.getNextBullet().fireAtAngle(20 + bulrot);
			this.getNextBullet().fireAtAngle(40 + bulrot);
			this.getNextBullet().fireAtAngle(60 + bulrot);
			this.getNextBullet().fireAtAngle(80 + bulrot);
			this.getNextBullet().fireAtAngle(100 + bulrot);
			this.getNextBullet().fireAtAngle(120 + bulrot);
			this.getNextBullet().fireAtAngle(140 + bulrot);
			this.getNextBullet().fireAtAngle(160 + bulrot);
			this.getNextBullet().fireAtAngle(180 + bulrot);
			
			this.getNextBullet().fireAtAngle(-20 + bulrot);
			this.getNextBullet().fireAtAngle(-40 + bulrot);
			this.getNextBullet().fireAtAngle(-60 + bulrot);
			this.getNextBullet().fireAtAngle(-80 + bulrot);
			this.getNextBullet().fireAtAngle(-100 + bulrot);
			this.getNextBullet().fireAtAngle(-120 + bulrot);
			this.getNextBullet().fireAtAngle(-140 + bulrot);
			this.getNextBullet().fireAtAngle(-160 + bulrot);
			
			/*
			var bul2:Bullet = this.getNextBullet()
			bul2.fireAtPoint(targetX, targetY);
			bul2.y -= 65;
			
			var bul3:Bullet = this.getNextBullet()
			bul3.fireAtPoint(targetX, targetY);
			
			var bul4:Bullet = this.getNextBullet()
			bul4.fireAtPoint(targetX, targetY);
			bul4.y += 125;
			
			var bul5:Bullet = this.getNextBullet()
			bul5.fireAtPoint(targetX, targetY);
			bul5.y -= 95;
			*/
			return true;
		}
    }
}