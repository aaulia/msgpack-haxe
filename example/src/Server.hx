package;

import haxe.remoting.Context;
import org.msgpack.rpc.MsgPackRpcServer;

class Server {
	static public function main() {
		var ctx = new Context();
		ctx.addObject("Api", new Api()); // Client Proxy must use Connection.<Name of Object in Context>
		MsgPackRpcServer.run(ctx);
	}
}
