﻿package uk.co.gavd.enemies {
	import uk.co.gavd.Game;
	import uk.co.gavd.ballistics.Bullet;
	import flash.display.*;
	import flash.events.Event;

    public class Turret extends Enemy {
		
		private var rateOfFire:Number = 44;
		private var clicksToFire:Number = 0;
		private var fireRange:Number = 600;
		private var scoreForKill:Number = 4;
		
		private var hp:Number = 5;
		
		public function Turret(game:Game) {
			super(game);
		}
		
		// stub out methods that don't apply to turrets
		override protected function handleMovementY():void {}
		override protected function handleMovementX():void {}
		
		override protected function doFire (lTargetX:Number, distFromHero:Number):Boolean {
			trace("FIRE BULLET AT TARGET");
			if(--this.clicksToFire <= 0) {
				this.clicksToFire = this.rateOfFire;
			} else {
				return false;
			}
			
	//		_root.sfx.gotoAndPlay("enemyFireTurret" + this.fireType); // TODO bomber fire
			
			var bul:Bullet = this.getNextBullet()
			bul.addEventListener ( Event.ENTER_FRAME, bul.doFrame, false, 0, true);
			bul.fireAtTarget(game.hero);
			
			return true;
		}
		
		public function takeHit():void {
			var theRootx:MovieClip = MovieClip(root); // TODO DI this?
			this.hp -= theRootx.game.hero.power;
			if(this.hp <= 0) {
				theRootx.fcEnemies.kill(this);
			} else {
				//this["hitFlash"].gotoAndPlay(1);
				theRootx.sfxEnemyExplosions.gotoAndPlay("hit");
			}
		}
    }
}