import test.uk.co.gavd.HeroTest;

class AllTests extends asunit.framework.TestSuite {
	private var className:String = "AllTests";

	public function AllTests() {
		super();
		trace("ALL TESTS");
		var tmp = new HeroTest();
		addTest(tmp);
	}
}
