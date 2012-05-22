package uk.co.gavd.diagnostics
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;

    /**
	 * Adapted from GuiltFilter's code on
	 * http://www.actionscript.org/forums/showthread.php3?t=171724
	 */
    public class TimelineUtils
    {
		public static function countTree(sym):uint {
			
			var count:int = sym.numChildren; 
			var len:int = sym.numChildren;  
			
			for (var i:int = 0; i < len; i++) {  
				var display:DisplayObject = sym.getChildAt(i);  
				if(display is MovieClip) {
					count += countTree(display);
				}
			}
			
			return count;
		}
	
		public static function dispTree(sym, indent:uint):void {
			var len:int = sym.numChildren;  
			for (var i:int = 0; i < len; i++) {  
				var display:DisplayObject = sym.getChildAt(i);  
				
				if (display == null ) {
					trace("Item at " + i + " is null");
				}
				
				var s:String = "";
				for(var n:int = 0; n <= indent; n++) {
					s += " ";
				}
				
				trace(s + /*display.name +*/ "[" + ClassUtils.getClass(display) + "]");  
				if(display is MovieClip) {
					dispTree(display, indent + 1);
				}
			}  
		}
    }
}