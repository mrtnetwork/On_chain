import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns the number of transactions in a block from a block matching the given block hash.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getBlockTransactionCountByHash)
class EthereumRequestGetGetBlockTransactionCountByHash
    extends EthereumRequest<int, Object> {
  EthereumRequestGetGetBlockTransactionCountByHash({
    required this.blockHash,
  });

  /// eth_getBlockTransactionCountByHash
  @override
  String get method => EthereumMethods.getBlockTransactionCountByHash.value;

  /// hash of a block
  final String blockHash;

  @override
  List<dynamic> toJson() {
    return [blockHash];
  }

  @override
  int onResonse(result) {
    return EthereumRequest.onIntResponse(result);
  }

  @override
  String toString() {
    return 'EthereumRequestGetGetBlockTransactionCountByHash{${toJson()}}';
  }
}
