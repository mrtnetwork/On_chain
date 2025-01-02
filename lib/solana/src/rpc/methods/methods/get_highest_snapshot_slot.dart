import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';

/// Returns the highest slot information that the node has snapshots for.
///
/// This will find the highest full snapshot slot,
/// and the highest incremental snapshot slot based on the full snapshot slot, if there is one.
///
/// https://solana.com/docs/rpc/http/gethighestsnapshotslot
class SolanaRequestGetHighestSnapshotSlot
    extends SolanaRequest<Map<String, dynamic>, Map<String, dynamic>> {
  /// getHighestSnapshotSlot
  @override
  String get method => SolanaRequestMethods.getHighestSnapshotSlot.value;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
