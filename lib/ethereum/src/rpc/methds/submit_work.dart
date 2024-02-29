import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class RPCSubmitWork extends ETHRPCRequest<dynamic> {
  RPCSubmitWork(
      {required this.nonce, required this.hash, required this.digest});

  /// eth_submitWork
  @override
  EthereumMethods get method => EthereumMethods.submitWork;
  final String nonce;
  final String hash;
  final String digest;
  @override
  List<dynamic> toJson() {
    return [nonce, hash, digest];
  }

  @override
  String toString() {
    return "RPCSubmitWork{${toJson()}}";
  }
}
