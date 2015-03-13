package ;

import haxe.Int64;
import massive.munit.Assert;
import org.msgpack.MsgPack;

class Int64Test
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
		var e = MsgPack.encode(Int64.make(1,2));
		var d = MsgPack.decode(e);

		Assert.isTrue(Std.is(d, Int64));
		Assert.isTrue(Int64.getHigh(d) == 1);
		Assert.isTrue(Int64.getLow(d) == 2);
	}
}