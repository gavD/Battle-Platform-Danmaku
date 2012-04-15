package uk.co.gavd.danmakuengine {
    import flash.display.*;
    import flash.events.*;
	
    public class HealthBar extends MovieClip {
        protected var hero:Hero;
		
		public var green:MovieClip;
		public var red:MovieClip;
		
		protected var barWidth:int = 100;

		public function HealthBar(hero:Hero, barWidth:int) {
			this.hero = hero;
			this.width = barWidth;
			this.alpha = .5;
			this.addEventListener ( Event.ENTER_FRAME, this.doFrame, false, 0, true);
		}
		
		protected function doFrame(e:Event):void {
			this.green.width = this.width * (this.hero.getEnergy() / this.hero.getMaxEnergy());
		}
    }
}