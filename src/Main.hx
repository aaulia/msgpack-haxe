package;

import haxe.unit.TestCase;
import haxe.unit.TestRunner;
import org.msgpack.MsgPack;

class TestMsgPack extends TestCase {

	public function testNull     () { assertEquals(MsgPack.decode(MsgPack.encode(null)), null); }
	public function testPosFixNum() { assertEquals(MsgPack.decode(MsgPack.encode( 127)),  127); }
	public function testNegFixNum() { assertEquals(MsgPack.decode(MsgPack.encode( -32)),  -32); }
	public function testBoolean  () { assertEquals(MsgPack.decode(MsgPack.encode(true)), true); }
	
	public function testFloat() {
		var f:Float = 1.234;
		var v:Float = MsgPack.decode(MsgPack.encode(f));
		assertTrue( Math.abs(v - f) < 0.0001 );
	}

	function array_compare<T>(a:Array<T>, b:Array<T>) {
		if (a.length != b.length) 
			return false;

		var r = true;
		for (i in 0...a.length) {
			r = r && (a[i] == b[i]);
		}
		return r;
	}

	public function testFixArray() {
		var v = [1, 2, 3, 4, 5];
		var r = MsgPack.decode(MsgPack.encode(v));
		assertTrue(array_compare(v, r));
	}

	function hash_compare<T>(a:Hash<T>, b:Hash<T>) {
		var j = Lambda.count(a);
		var k = Lambda.count(b);
		if (j != k)
			return false;

		var r = true;
		for (k in a.keys()) {
			r = r && (a.get(k) == b.get(k));
		}
		return r;
	}

	public function testHashMap() {
		var v = new Hash<Int>();
		v.set("abc", 123);
		v.set("def", 456);
		v.set("ghi", 789);
		var r = MsgPack.decode(MsgPack.encode(v));
		assertTrue(hash_compare(v, r));
	}

	public function testString() {
		assertEquals(MsgPack.decode(MsgPack.encode("Hello World!")), "Hello World!"); 
	}

}

class Main {
	static public function main() {
		var test = new TestRunner();
		test.add(new TestMsgPack());
		test.run();
	}
}
