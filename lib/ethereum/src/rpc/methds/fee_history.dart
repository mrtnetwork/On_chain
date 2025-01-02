import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/ethereum/src/models/fee_history.dart';

class EthereumRequestGetFeeHistory
    extends EthereumRequest<FeeHistory?, Map<String, dynamic>?> {
  EthereumRequestGetFeeHistory(
      {required this.blockCount,
      required BlockTagOrNumber newestBlock,
      required this.rewardPercentiles})
      : super(blockNumber: newestBlock);

  /// eth_feeHistory
  @override
  String get method => EthereumMethods.getFeeHistory.value;
  final int blockCount;
  final List<double> rewardPercentiles;
  @override
  List<dynamic> toJson() {
    return [
      '0x${blockCount.toRadixString(16)}',
      blockNumber,
      rewardPercentiles
    ];
  }

  @override
  FeeHistory? onResonse(result) {
    if (result == null || result['gasUsedRatio'] == null) return null;
    return FeeHistory.fromJson(result);
  }
}
