import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns information about a transaction by block hash and transaction index position.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getTransactionByBlockHashAndIndex)
class EthereumRequestGetTransactionByBlockHashAndIndex
    extends EthereumRequest<Map<String, dynamic>?, Map<String, dynamic>?> {
  EthereumRequestGetTransactionByBlockHashAndIndex(
      {required this.blockHash, required this.index});

  /// eth_getTransactionByBlockHashAndIndex
  @override
  String get method => EthereumMethods.getTransactionByBlockHashAndIndex.value;

  /// hash of a block.
  final String blockHash;

  /// integer of the transaction index position.
  final int index;

  @override
  List<dynamic> toJson() {
    return [blockHash, '0x${index.toRadixString(16)}'];
  }

  @override
  String toString() {
    return 'EthereumRequestGetTransactionByBlockHashAndIndex{${toJson()}}';
  }
}
