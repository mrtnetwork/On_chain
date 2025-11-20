import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns the information about a transaction requested by transaction hash.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getTransactionByHash)
class EthereumRequestGetRawTransactionByHash
    extends EthereumRequest<String?, String?> {
  EthereumRequestGetRawTransactionByHash({
    required this.transactionHash,
  });

  /// eth_getTransactionByHash
  @override
  String get method => EthereumMethods.getRawTransactionByHash.value;

  /// hash of a transaction
  final String transactionHash;

  @override
  List<dynamic> toJson() {
    return [transactionHash];
  }

  @override
  String toString() {
    return 'EthereumRequestGetRawTransactionByHash{${toJson()}}';
  }
}
