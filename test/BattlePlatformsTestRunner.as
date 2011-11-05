import asunit.textui.TestRunner;
import AllTests;

class BattlePlatformsTestRunner extends TestRunner {
	public static function main():void {
		var runner = new BattlePlatformsTestRunner();
	}
	
	public function BattlePlatformsTestRunner() {
		trace("= Start testing =");
		start(AllTests, null, true);
		trace("= Done =");
		
		
		
		var endTime:Number = getTimer();
		var runTime:Number = endTime - startTime;
		trace("Test complete");
		getPrinter().printResult(result, runTime);
	}
}
