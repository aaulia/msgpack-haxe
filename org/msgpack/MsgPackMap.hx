package org.msgpack;

import haxe.ds.IntMap;
import haxe.ds.StringMap;

private class Pair {
	public var key:Dynamic;
	public var value:Dynamic;
	public function new(key:Dynamic, value:Dynamic) {
		this.key = key;
		this.value = value;
	}
}

class MsgPackMap {
	var _data:Array<Pair>;

	public function new() {
		_data = [];
	}

	public inline function add(k:Dynamic, v:Dynamic):Void {
		_data.push(new Pair(k,v));
	}

	public inline function iterator():Iterator<Pair> {
		return _data.iterator();
	}

	static function stringTypeof(d:Dynamic):String{
		var type = Type.typeof(d);
		return switch(type){
		case TNull | TInt | TFloat | TBool | TObject | TFunction | TUnknown : return Std.string(type);
		case TClass(c): return Type.getClassName(c);
		case TEnum(e): return Type.getEnumName(e);
		}
	}

	public function toStringMap():StringMap<Dynamic> {
		var res = new StringMap<Dynamic>();
		for (kv in this){
			if (!Std.is(kv.key, String)) throw 'All keys should be strings, found ${kv.key}:${stringTypeof(kv.key)}';
			if (res.exists(kv.key)) throw 'All keys should be unique, ${kv.key} duplicated';
			res.set(kv.key, kv.value);
		}
		return res;
	}

	public function toIntMap():IntMap<Dynamic> {
		var res = new IntMap<Dynamic>();
		for (kv in this){
			if (!Std.is(kv.key, Int)) throw 'All keys should be ints, found ${kv.key}:${stringTypeof(kv.key)}';
			if (res.exists(kv.key)) throw 'All keys should be unique, ${kv.key} duplicated';
			res.set(kv.key, kv.value);
		}
		return res;
	}

	public function toObject():Dynamic {
		var res = {};
		for (kv in this){
			if (!Std.is(kv.key, String)) throw 'All keys should be strings, found ${kv.key}:${stringTypeof(kv.key)}';
			if (Reflect.hasField(res, kv.key)) throw 'All keys should be unique, ${kv.key} duplicated';
			Reflect.setField(res, kv.key, kv.value);
		}
		return res;
	}
}
