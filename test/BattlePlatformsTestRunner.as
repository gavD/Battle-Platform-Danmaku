import asunit.textui.TestRunner;
import AllTests;

class ExampleTestRunner extends TestRunner {
	public static function main():Void {
		trace("MAIN");
		var runner = new ExampleTestRunner();
	}
	
	public function ExampleTestRunner() {
		trace("CONST");
		fscommand("fullscreen", "true");
		
		start(AllTests);
		trace("DONE");
	}
}