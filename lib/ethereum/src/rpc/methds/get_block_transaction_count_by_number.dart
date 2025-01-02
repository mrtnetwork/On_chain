import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns the number of transactions in a block matching the given block number.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getBlockTransactionCountByNumber)
class EthereumRequestGetBlockTransactionCountByNumber
    extends EthereumRequest<int, Object> {
  EthereumRequestGetBlockTransactionCountByNumber({
    BlockTagOrNumber tag = BlockTagOrNumber.finalized,
  }) : super(blockNumber: tag);

  /// eth_getBlockTransactionCountByNumber
  @override
  String get method => EthereumMethods.getBlockTransactionCountByNumber.value;

  @override
  List<dynamic> toJson() {
    return [blockNumber];
  }

  @override
  int onResonse(result) {
    return EthereumRequest.onIntResponse(result);
  }

  @override
  String toString() {
    return 'EthereumRequestGetBlockTransactionCountByNumber{${toJson()}}';
  }
}
