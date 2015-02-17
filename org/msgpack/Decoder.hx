package org.msgpack;

import haxe.ds.StringMap;
import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.io.Eof;

using Reflect;

enum DecodeMaps {
	AsMsgPackMap;
	AsObject;
	AsStringMap;
	AsIntMap;
}

class Decoder {
	var o:Dynamic;

	public function new(b:Bytes, maps:DecodeMaps) {
		var i       = new BytesInput(b);
		i.bigEndian = true;
		o           = decode(i, maps);
	}

	function decode(i:BytesInput, maps):Dynamic {
		try {
			var b = i.readByte();
			switch (b) {
				// null
				case 0xc0: return null;

				// boolean
				case 0xc2: return false;
				case 0xc3: return true;

				// binary
				case 0xc4: return i.read(i.readByte());
				case 0xc5: return i.read(i.readUInt16());
				case 0xc6: return i.read(i.readInt32());

				// floating point
				case 0xca: return i.readFloat ();
				case 0xcb: return i.readDouble();
				
				// unsigned int
				case 0xcc: return i.readByte  ();
				case 0xcd: return i.readUInt16();
				case 0xce: return i.readInt32 ();
				case 0xcf: throw "UInt64 not supported";

				// signed int
				case 0xd0: return i.readInt8 ();
				case 0xd1: return i.readInt16();
				case 0xd2: return i.readInt32();
				case 0xd3: throw "Int64 not supported";

				// string
				case 0xd9: return i.readString(i.readByte());
				case 0xda: return i.readString(i.readUInt16());
				case 0xdb: return i.readString(i.readInt32());

				// array 16, 32
				case 0xdc: return readArray(i, i.readUInt16(), maps);
				case 0xdd: return readArray(i, i.readInt32(), maps);

				// map 16, 32
				case 0xde: return readMap(i, i.readUInt16(), maps);
				case 0xdf: return readMap(i, i.readInt32(), maps);

				default  : {
					if (b < 0x80) {	return b;                            } else // positive fix num
					if (b < 0x90) { return readMap(i, (0xf & b), maps);   } else // fix map
					if (b < 0xa0) { return readArray(i, (0xf & b), maps); } else // fix array
					if (b < 0xc0) { return i.readString(0x1f & b);       } else // fix string
					if (b > 0xdf) { return 0xffffff00 | b;               }      // negative fix num
				}
			}
		} catch (e:Eof) {}
		return null;
	}

	function readArray(i, length, maps) {
		var a = [];
		for(x in 0...length) {
			a.push(decode(i, maps));
		}
		return a;
	}

	function readMap(i, length, maps):Dynamic {
		var m = new MsgPackMap();
		for (x in 0...length) {
			var k = decode(i, maps);
			var v = decode(i, maps);
			m.add(k, v);
		}

		return switch(maps){
			case DecodeMaps.AsMsgPackMap: m;
			case DecodeMaps.AsObject: m.toObject();
			case DecodeMaps.AsStringMap: m.toStringMap();
			case DecodeMaps.AsIntMap: m.toIntMap();
		}
	}

	public inline function getResult() {
		return o;
	}
}
