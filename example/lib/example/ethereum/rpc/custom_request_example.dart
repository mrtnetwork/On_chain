import 'package:on_chain/ethereum/src/models/models.dart';
import 'package:on_chain/ethereum/src/rpc/rpc.dart';
import 'package:on_chain/ethereum/src/utils/helper.dart';

import 'http_service.dart';

/// create custom request class to get balance and convert to String
class RPCGetStringBalance extends EthereumRequest<String, dynamic> {
  RPCGetStringBalance(
      {required this.address, BlockTagOrNumber? tag = BlockTagOrNumber.latest})
      : super(blockNumber: tag);

  /// eth_getBalance
  @override
  String get method => EthereumMethods.getBalance.value;

  ///  address to check for balance.
  final String address;

  @override
  List<dynamic> toJson() {
    return [address, blockNumber];
  }

  @override
  String onResonse(dynamic result) {
    final balance = EthereumRequest.onBigintResponse(result);

    return ETHHelper.fromWei(balance);
  }

  @override
  String toString() {
    return "RPCGetBalance{${toJson()}}";
  }
}

void main() async {
  /// create service please see http_service_example.dart and socket_rpc_service for create http and websocket service
  final httpRpc = RPCHttpService("https://bsc-testnet.drpc.org/");

  /// pass your service in evm rpc
  final rpc = EthereumProvider(httpRpc);

  /// make request
  // ignore: unused_local_variable
  final balance = await rpc.request(

      /// pass custom class to request method
      RPCGetStringBalance(
          address: "0x7Fbb78c66505876284a49Ad89BEE3df2e0B7ca5E"));

  /// 0.29923043024 BNB
}
