package ;

import haxe.ds.IntMap;
import haxe.ds.StringMap;
import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import org.msgpack.Decoder.DecodeOption.AsMap;
import org.msgpack.MsgPack;


class MapTest 
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
		var im = new IntMap<String>();
		im.set(1, "one");
		im.set(3, "Three");
		im.set(9, "Nine");

		var e = MsgPack.encode(im);
		var d = MsgPack.decode(e, AsMap);

		Assert.isType(d, IntMap);

		var ni = cast(d, IntMap<Dynamic>);
		for (k in im.keys())
			Assert.isTrue(ni.exists(k) && ni.get(k) == im.get(k));


		var sm = new StringMap<Int>();
		sm.set("one",   1);
		sm.set("Three", 3);
		sm.set("Nine",  9);

		e = MsgPack.encode(sm);
		d = MsgPack.decode(e, AsMap);

		Assert.isType(d, StringMap);

		var ns = cast(d, StringMap<Dynamic>);
		for (k in sm.keys())
			Assert.isTrue(ns.exists(k) && ns.get(k) == sm.get(k));

	}
}