package ;

import haxe.io.Bytes;
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
		Assert.isNull(doTest(null));
		Assert.isType(doTest(true), Bool);
		Assert.isType(doTest(1000), Int);
		Assert.isType(doTest(1.01), Float);
		Assert.isType(doTest("ab"), String);
		Assert.isType(doTest(Bytes.ofString("ab")), Bytes);

		Assert.areEqual(doTest(null), null);
		Assert.isTrue(doTest(true));
		Assert.areEqual(doTest(1000), 1000);
		Assert.isTrue(Math.abs(1.01 - cast doTest(1.01)) <= 0.00000001);
		Assert.areEqual(doTest("ab"), "ab");

		var d = cast(doTest(Bytes.ofString("ab")), Bytes);
		var a = Bytes.ofString("ab");
		
		Assert.isTrue((d.length == a.length) && (d.toString() == a.toString()));
	}

	function doTest<T>(a:T)
	{
		var e = MsgPack.encode(a);
		var d = MsgPack.decode(e);

		return d;
	}
}