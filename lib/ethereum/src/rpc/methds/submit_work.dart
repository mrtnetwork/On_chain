import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class EthereumRequestSubmitWork extends EthereumRequest<Object?, Object?> {
  EthereumRequestSubmitWork(
      {required this.nonce, required this.hash, required this.digest});

  /// eth_submitWork
  @override
  String get method => EthereumMethods.submitWork.value;
  final String nonce;
  final String hash;
  final String digest;
  @override
  List<dynamic> toJson() {
    return [nonce, hash, digest];
  }

  @override
  String toString() {
    return 'EthereumRequestSubmitWork{${toJson()}}';
  }
}
