import asunit.framework.TestCase;
import uk.co.gavd.Hero;

class test.uk.co.gavd.HeroTest extends TestCase {
	private var className:String = "ExampleTest";
	private var instance:Hero;

	public function setUp():void {
		instance = new Hero();
	}
	
	public function HeroTest(testMethod:String) {
		super(testMethod);
	}

	public function testMe():void {
		trace("GO HERO TEST x");
		assertFalse("failing test", false);
	}

	public function tearDown():void {
		delete instance;
 	}
}