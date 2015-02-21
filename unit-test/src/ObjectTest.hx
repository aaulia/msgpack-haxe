package ;

import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import org.msgpack.Decoder.DecodeOption.AsObject;
import org.msgpack.MsgPack;


class ObjectTest 
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
		var e = MsgPack.encode({ a: 10, b: "abc"});
		var d = MsgPack.decode(e, AsObject);

		Assert.isTrue(Reflect.hasField(d, "a") 
				   && Reflect.hasField(d, "b") 
				   && Reflect.field(d, "a") == 10 
				   && Reflect.field(d, "b") == "abc");
	}
}