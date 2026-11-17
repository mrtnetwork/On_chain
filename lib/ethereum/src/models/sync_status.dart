import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/utils/utils/number_utils.dart';

/// Result of `eth_syncing`: `false` when the node is in sync, otherwise
/// the sync progress checkpoints.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_syncing)
class EthereumSyncStatus {
  /// Whether the node is currently syncing.
  final bool isSyncing;

  /// Block number the sync started from (syncing only).
  final BigInt? startingBlock;

  /// Block number the node is currently at (syncing only).
  final BigInt? currentBlock;

  /// Highest known block number (syncing only).
  final BigInt? highestBlock;

  const EthereumSyncStatus({
    required this.isSyncing,
    this.startingBlock,
    this.currentBlock,
    this.highestBlock,
  });

  /// Parses the `eth_syncing` response (`false` or a progress object).
  factory EthereumSyncStatus.fromResponse(Object? result) {
    if (result is bool) {
      return EthereumSyncStatus(isSyncing: result);
    }
    final json = (result as Map).cast<String, dynamic>();
    return EthereumSyncStatus(
      isSyncing: true,
      startingBlock: PluginBigintUtils.tryHexToBigint(json['startingBlock']),
      currentBlock: PluginBigintUtils.tryHexToBigint(json['currentBlock']),
      highestBlock: PluginBigintUtils.tryHexToBigint(json['highestBlock']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "isSyncing": isSyncing,
      "startingBlock": startingBlock?.toHexaDecimal,
      "currentBlock": currentBlock?.toHexaDecimal,
      "highestBlock": highestBlock?.toHexaDecimal,
    };
  }
}
