msgpack-haxe
============

MessagePack (http://msgpack.org) serialization library for HaXe

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
