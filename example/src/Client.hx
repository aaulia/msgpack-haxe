package;
import haxe.remoting.AsyncProxy;
import org.msgpack.rpc.MsgPackRpcClient;

class ApiProxy extends AsyncProxy<Api> {}
class Client {
	static public function main() {
		var con = MsgPackRpcClient.connect("http://aaulia/send_raw_binary/", "Api");
		var api = new ApiProxy(con);
		api.add(1, 2, function(r) { trace(r); });
	}
}
