package ;

import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import org.msgpack.MsgPack;


class BasicTest 
{
	
	
	public function new() 
	{
		
	}
	
	@BeforeClass
	public function beforeClass():Void
	{
	}
	
	@AfterClass
	public function afterClass():Void
	{
	}
	
	@Before
	public function setup():Void
	{
	}
	
	@After
	public function tearDown():Void
	{
	}
	
	@Test
	public function testExample():Void
	{
		Assert.isTrue(doTest(null, "TNull" ));
		Assert.isTrue(doTest(true, "TBool" ));
		Assert.isTrue(doTest(1000, "TInt"  ));
		Assert.isTrue(doTest(1.01, "TFloat"));
		Assert.isTrue(doTest("ab", "String"));
	}

	function doTest<T>(a:T, n:String)
	{
		var e = MsgPack.encode(a);
		var d = MsgPack.decode(e);

		switch (Type.typeof(a))
		{
			case TNull    : return n == "TNull";
			case TBool    : return n == "TBool";
			case TInt     : return n == "TInt";
			case TFloat   : return n == "TFloat";
			case TClass(c):
				switch (Type.getClassName(c))
				{
					case "String":
						return n == "String";
				}

			default:
		}
		
		return false;
	}
}