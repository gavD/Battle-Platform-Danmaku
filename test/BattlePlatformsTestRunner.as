import asunit.textui.TestRunner;
import AllTests;

class BattlePlatformsTestRunner extends TestRunner {
	public static function main():Void {
		trace("MAIN");
		var runner = new BattlePlatformsTestRunner();
	}
	
	public function BattlePlatformsTestRunner() {
		trace("CONST");
		fscommand("fullscreen", "true");
		
		start(AllTests);
		trace("DONE");
	}
}
