﻿package uk.co.gavd.danmakuengine.enemies {
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.ballistics.*;
	import flash.display.*;
	import flash.events.Event;
	import flash.media.Sound;

    public class Guardian3 extends Turret {
		
		private var gameAffected:Boolean = false;
		private var bulrot:int = 0;
		private var rotrate:int = 5;
		private var bulletCloudDensity:Number = 45;
		private var shotPtr:uint = 0;
		
		private var shotFrames:Array = [
			1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			2, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			2, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			2, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			3, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		];
		
		
		public function Guardian3() {
			super();
			
			this.fireRange = 800;
			this.scoreForKill = 400;
			this.rateOfFire = 9;
			this.hp = 300;
			
			this.fireSound = new BulletGuardian1Wav();
		}
		
		
		override protected function getOnScreenMin():uint {
			return 570;
		}
		
		override protected function getNewBullet():Bullet {
			var shotType:uint = shotFrames[shotPtr];
			
			if(shotType === 1) {
				return new BulletLong20pxPink(game);
			} else if (shotType === 2) {
				return new BulletLong20pxYellow(game);
			} else {
				return new BulletLong20pxGreen(game);
			}
		}
		
		override protected function dieHook():void {
			game.startScrolling();
		}
		
		override public function takeHit():void {
			super.takeHit();
			if (this.hp < 100) {
				bulletCloudDensity = 5.625;
			}else if (this.hp < 200) {
				bulletCloudDensity = 11.25;
			} else if(this.hp < 250) {
				bulletCloudDensity = 22.5;
			} else {
				trace("HULK 0");
				this.x--;
			}
		}
		
		override protected function doFire (lTargetX:Number, distFromHero:Number):void {
			
			if(!gameAffected) {
				game.stopScrolling();
				gameAffected = true;
			}
			
			if(++shotPtr > shotFrames.length) {
				shotPtr = 0;
			}
			
			if(shotFrames[shotPtr] === 0) {
				return;
			}
			
			if(bulrot > 180) {
				bulrot -= 180;
			}
			bulrot += rotrate;
			
			for(var i:int = -180; i < 180; i = i + bulletCloudDensity) {
				this.getNextBullet().fireAtAngle(i + bulrot, true);
			}
		}
    }
}