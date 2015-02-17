package org.msgpack;

import haxe.io.Bytes;
import org.msgpack.Decoder.DecodeMaps;

class MsgPack {

	public static inline function encode(d:Dynamic):Bytes { 
		return new Encoder(d).getBytes(); 
	}

	public static inline function decode(b:Bytes, ?maps:DecodeMaps):Dynamic {
		if (maps == null) maps = DecodeMaps.AsObject;
		return new Decoder(b, maps).getResult();
	}

}
