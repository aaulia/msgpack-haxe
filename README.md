[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](license.txt) [![Haxelib Version](https://img.shields.io/github/release/aaulia/msgpack-haxe.svg?style=flat&label=haxelib)](http://lib.haxe.org/p/msgpack-haxe)

msgpack-haxe
============

MessagePack (http://msgpack.org) serialization library for Haxe

How to install:
-------------
Simply use `haxelib git` to use this github repo or `haxelib install msgpack-haxe` to use the one in the haxelib repository.

Supported Type:
-------------
* Null
* Bool
* Int
* Float
* Object
* Bytes
* String
* Array
* IntMap/StringMap

Example code:
-------------
``` haxe
package;
import org.msgpack.MsgPack;

class Example {
    public static function main() {
        var i = { a: 1, b: 2, c: "Hello World!" };
        var m = MsgPack.encode(i);
        var o = MsgPack.decode(m);

        trace(i);
        trace(m.toHex());
        trace(o);
    }
}
```
