import 'package:blockchain_utils/helper/helper.dart';
import 'package:on_chain/ethereum/src/models/block.dart';
import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns information about a uncle of a block by number and uncle index position.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getUncleByBlockNumberAndIndex)
class EthereumRequestGetUncleByBlockNumberAndIndex
    extends EthereumRequest<BlockDetails?, Map<String, dynamic>?> {
  EthereumRequestGetUncleByBlockNumberAndIndex({
    required BlockTagOrNumber blockNumber,
    required this.uncleIndex,
  }) : super(blockNumber: blockNumber);

  /// eth_getUncleByBlockNumberAndIndex
  @override
  String get method => EthereumMethods.getUncleByBlockNumberAndIndex.value;

  /// the uncle's index position.
  final int uncleIndex;

  @override
  List<dynamic> toJson() {
    return [blockNumber, uncleIndex.toHexaDecimal];
  }

  @override
  BlockDetails? onResponse(result) {
    if (result == null) return null;
    return BlockDetails.fromJson(result);
  }

  @override
  String toString() {
    return 'EthereumRequestGetUncleByBlockNumberAndIndex{${toJson()}}';
  }
}
