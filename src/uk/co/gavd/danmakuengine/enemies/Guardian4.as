package uk.co.gavd.danmakuengine.enemies {
	import uk.co.gavd.danmakuengine.ballistics.firingpatterns.Circle;
	import uk.co.gavd.danmakuengine.ballistics.firingpatterns.FiringPattern;
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.ballistics.*;
	import flash.display.*;
	import flash.events.Event;
	import flash.media.Sound;
	import uk.co.gavd.danmakuengine.ballistics.firingpatterns.SpinTriplet;

    public class Guardian4 extends Turret {
		
		private var gameAffected:Boolean = false;
		protected var firePatterns:Array;
		private var firePatternCount:uint;
		
		public function Guardian4() {
			super();
			
			this.fireRange = 800;
			this.scoreForKill = 600;
			this.rateOfFire = 9;
			this.hp = 400;
			
			this.fireSound = new BulletGuardian1Wav();
			this.firePatterns = new Array();
		}
		
		override protected function turnAndFace(targetX:Number):void
		{}
		
		override protected function getOnScreenMin():uint {
			return 630;
		}
		
		override protected function dieHook():void {
			game.startScrolling();
		}
		
		override public function setGame(game:Game):void {
			super.setGame(game);
			
			this.firePatterns.push(new SpinTriplet(this.game, this, 7,	2, -40));
			this.firePatterns.push(new SpinTriplet(this.game, this, 7,	2, -20));
			this.firePatterns.push(new SpinTriplet(this.game, this, 7,	2, 0));
			
			this.firePatterns.push(new SpinTriplet(this.game, this, 7, -2, 0));
			this.firePatterns.push(new SpinTriplet(this.game, this, 7, -2, 20));
			this.firePatterns.push(new SpinTriplet(this.game, this, 7, -2, 40));
			
			this.firePatterns.push(new Circle(this.game, this, 70, 1, 0, 6));
			
			this.firePatternCount = firePatterns.length;
		}
		
		override protected function doFire (lTargetX:Number, distFromHero:Number):void {
			
			if(!gameAffected) {
				game.stopScrolling();
				gameAffected = true;
			}
			
			for (var i:uint = 0; i < firePatternCount; i++) {
				this.firePatterns[i].process();
			}
		}
    }
}