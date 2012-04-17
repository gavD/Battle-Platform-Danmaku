package uk.co.gavd.danmakuengine {
    import flash.display.*;
    import flash.events.*;
	
    public class HealthBar extends MovieClip {
        
		public var green:MovieClip;
		public var red:MovieClip;
		
		private var hero:Hero;
		private var barWidth:int = 100;
		
		public function HealthBar(hero:Hero, barWidth:int) {
			this.hero = hero;
			this.width = barWidth;
			this.alpha = .5;
			this.addEventListener ( Event.ENTER_FRAME, this.doFrame, false, 0, true);
		}
		
		protected function doFrame(e:Event):void {
			var desiredWidth:Number = this.width * (this.hero.getEnergy() / this.hero.getMaxEnergy());
			if(this.green.width < desiredWidth) {
				this.green.width += 7;
				if(this.green.width > desiredWidth) {
					this.green.width = desiredWidth;
				}
				return;
			} else if (this.green.width > desiredWidth) {
				this.green.width -= 2;
				if(this.green.width < desiredWidth) {
					this.green.width = desiredWidth;
				}
				return;
			}
		}
    }
}