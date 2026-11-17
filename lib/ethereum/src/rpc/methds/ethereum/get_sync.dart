import 'package:on_chain/ethereum/src/models/sync_status.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns an object with data about the sync status or false.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_syncing)
class EthereumRequestGetSyncing
    extends EthereumRequest<EthereumSyncStatus, Object> {
  EthereumRequestGetSyncing();

  /// eth_syncing
  @override
  String get method => EthereumMethods.getSyncing.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  EthereumSyncStatus onResponse(result) {
    return EthereumSyncStatus.fromResponse(result);
  }

  @override
  String toString() {
    return 'EthereumRequestGetSyncing{${toJson()}}';
  }
}
