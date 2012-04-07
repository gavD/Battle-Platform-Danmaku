package uk.co.gavd.enemies {
	import uk.co.gavd.Game;
	import uk.co.gavd.ballistics.Bullet;
	import flash.display.*;
	import flash.events.Event;
	import flash.media.Sound;

    public class Turret extends Enemy {
		
		protected var rateOfFire:int = 44;
		protected var clicksToFire:int = 0;
		
		protected var fireSound:Sound;
		
		public function Turret(game:Game) {
			super(game);
			
			this.fireRange = 600;
			this.scoreForKill = 4;
			this.hp = 10;
			
			this.fireSound = new TurretWav();
		}
		
		// stub out methods that don't apply to turrets
		override protected function handleMovementY():void {}
		override protected function handleMovementX():void {}
		
		override protected function doFire (lTargetX:Number, distFromHero:Number):Boolean {
			
			if(--this.clicksToFire <= 0) {
				this.clicksToFire = this.rateOfFire;
			} else {
				return false;
			}
			
			this.fireSound.play();
			
			var bul:Bullet = this.getNextBullet()
			bul.addEventListener ( Event.ENTER_FRAME, bul.doFrame, false, 0, true);
			bul.fireAtTarget(game.hero);
			
			return true;
		}

    }
}