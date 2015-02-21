package ;

import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import org.msgpack.MsgPack;


class ArrayTest 
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
		var a = [ 3, 2, 1, 7, 8, 9 ];
		var e = MsgPack.encode(a);
		var d = MsgPack.decode(e);

		Assert.isType(d, Array);
		Assert.isTrue(Lambda.fold(d, function(v, b) {
				return b && a[Lambda.indexOf(d, v)] == v;
 			}, true));
	}
}