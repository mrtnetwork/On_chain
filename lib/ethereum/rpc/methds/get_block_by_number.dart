import 'package:on_chain/ethereum/models/block_tag.dart';
import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';
import 'package:on_chain/ethereum/models/block.dart';

/// Returns information about a block by block number.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getBlockByNumber)
class RPCGetBlockByNumber extends ETHRPCRequest<BlockDetails> {
  RPCGetBlockByNumber({
    required BlockTagOrNumber blockNumber,
    this.hydrated = true,
  }) : super(blockNumber: blockNumber);

  /// eth_getBlockByNumber
  @override
  EthereumMethods get method => EthereumMethods.getBlockByNumber;

  ///  If true it returns the full transaction objects, if false only the hashes of the transactions.
  final bool hydrated;

  @override
  List<dynamic> toJson() {
    return [blockNumber, hydrated];
  }

  @override
  BlockDetails onResonse(dynamic result) {
    return BlockDetails.fromJson(result, hydrated: hydrated);
  }

  @override
  String toString() {
    return "RPCGetBlockByNumber{${toJson()}}";
  }
}
