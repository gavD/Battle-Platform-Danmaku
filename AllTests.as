
class AllTests extends asunit.framework.TestSuite {
	private var className:String = "AllTests";

	public function AllTests() {
		super();
		trace("ALL TESTS");
		addTest(new HeroTest());
	}
}
