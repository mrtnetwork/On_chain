import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';
import 'package:on_chain/ethereum/models/block.dart';

/// Returns information about a block by hash.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getBlockByHash)
class RPCGetBlockByHash extends ETHRPCRequest<BlockDetails> {
  RPCGetBlockByHash({
    required this.blockHash,
    this.hydrated = true,
  });

  /// eth_getBlockByHash
  @override
  EthereumMethods get method => EthereumMethods.getBlockByHash;

  /// Hash of a block.
  final String blockHash;

  /// If true it returns the full transaction objects, if false only the hashes of the transactions.
  final bool hydrated;

  @override
  List<dynamic> toJson() {
    return [blockHash, hydrated];
  }

  @override
  BlockDetails onResonse(dynamic result) {
    return BlockDetails.fromJson(result, hydrated: hydrated);
  }

  @override
  String toString() {
    return "RPCGetBlockByHash{${toJson()}}";
  }
}
