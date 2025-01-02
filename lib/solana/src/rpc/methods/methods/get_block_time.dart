import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';

/// Returns the estimated production time of a block.
///
/// Each validator reports their UTC time to the ledger on a regular interval by intermittently
/// adding a timestamp to a Vote for a particular block. A requested block's time is calculated
/// from the stake-weighted mean of the Vote timestamps in a set of recent blocks recorded on the ledger.
///
/// https://solana.com/docs/rpc/http/getblocktime
class SolanaRequestGetBlockTime extends SolanaRequest<int, int> {
  const SolanaRequestGetBlockTime({required this.blockNumber});

  /// getBlockTime
  @override
  String get method => SolanaRequestMethods.getBlockTime.value;

  /// block number, identified by Slot
  final int blockNumber;

  @override
  List<dynamic> toJson() {
    return [blockNumber];
  }
}
