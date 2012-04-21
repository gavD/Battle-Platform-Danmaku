package uk.co.gavd.danmakuengine.hud {
    import flash.events.*;
    import uk.co.gavd.danmakuengine.Hero;
	
    public class HealthBar extends Bar {
        
		private var hero:Hero;
		
		public function HealthBar(hero:Hero, barWidth:int) {
			super(barWidth);
			this.hero = hero;
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