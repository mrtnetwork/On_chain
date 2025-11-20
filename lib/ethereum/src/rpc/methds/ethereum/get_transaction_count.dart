import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns the number of transactions sent from an address.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getTransactionCount)
class EthereumRequestGetTransactionCount extends EthereumRequest<int, Object> {
  EthereumRequestGetTransactionCount({
    required this.address,
    BlockTagOrNumber? tag = BlockTagOrNumber.latest,
  }) : super(blockNumber: tag);

  /// eth_getTransactionCount
  @override
  String get method => EthereumMethods.getTransactionCount.value;

  /// address
  final String address;

  @override
  List<dynamic> toJson() {
    return [address, blockNumber];
  }

  @override
  int onResonse(result) {
    return EthereumRequest.onIntResponse(result);
  }

  @override
  String toString() {
    return 'EthereumRequestGetTransactionCount{${toJson()}}';
  }
}
