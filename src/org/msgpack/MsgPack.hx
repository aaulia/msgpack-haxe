package org.msgpack;
import haxe.io.Bytes;

class MsgPack {

	public static inline function encode(d:Dynamic):Bytes { 
		return new Encoder(d).getBytes (); 
	}

	public static inline function decode(b:Bytes, obj = false):Dynamic { 
		return new Decoder(b, obj).getResult(); 
	}

}
