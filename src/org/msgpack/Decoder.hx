package org.msgpack;

import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.io.Eof;
using Reflect;

class Decoder {
	var o:Dynamic;

	public function new(b:Bytes, obj:Bool) {
		var i       = new BytesInput(b);
		i.bigEndian = true;
		o           = decode(i, obj);
	}

	function decode(i:BytesInput, obj):Dynamic {
		try {
			var b = i.readByte();
			switch (b) {
				// null
				case 0xc0: return null;

				// boolean
				case 0xc2: return false;
				case 0xc3: return true;

				// floating point
				case 0xca: return i.readFloat ();
				case 0xcb: return i.readDouble();
				
				// unsigned int
				case 0xcc: return i.readByte  ();
				case 0xcd: return i.readUInt16();
				case 0xce: return i.readUInt30();
				case 0xcf: throw "UInt64 not supported";

				// signed int
				case 0xd0: return i.readInt8 ();
				case 0xd1: return i.readInt16();
				case 0xd2: return i.readInt31();
				case 0xd3: throw "Int64 not supported";

				// raw 16, 32
				case 0xda, 0xdb: 
					return i.read(
						(b == 0xda)
							? i.readUInt16()
							: i.readUInt30()
					).toString();

				// array 16, 32
				case 0xdc, 0xdd:
					return readArray(
						i, 
						(b == 0xdc) 
							? i.readUInt16() 
							: i.readUInt30(),
						obj
					);

				// map 16, 32
				case 0xde, 0xdf: 
					return readMap(
						i,
						(b == 0xde)
							? i.readUInt16()
							: i.readUInt30(),
						obj
					);

				default  : {
					if (b < 0x80) {	return b;                            } else // positive fix num
					if (b < 0x90) { return readMap(i, (0xf & b), obj);   } else // fix map
					if (b < 0xa0) { return readArray(i, (0xf & b), obj); } else // fix array
					if (b < 0xc0) { return i.read(0x1f & b).toString();  } else // fix raw
					if (b > 0xdf) { return 0xffffff00 | b;               }      // negative fix num
				}
			}
		} catch (e:Eof) {}
		return null;
	}

	function readArray(i, length, obj) {
		var a = [];
		for(x in 0...length) {
			a.push(decode(i, obj));
		}
		return a;
	}

	function readMap(i, length, obj) {
		return if (!obj) {			
			var h = new Hash<Dynamic>();
			for (x in 0...length) {
				var k = decode(i, obj);
				var v = decode(i, obj);
				h.set(k, v);
			}
			h;		
		} else {
			var o = {};
			for (x in 0...length) {
				var k = decode(i, obj);
				var v = decode(i, obj);
				o.setField(k, v);
			}
			o;
		}
	}

	public inline function getResult() {
		return o;
	}
}
