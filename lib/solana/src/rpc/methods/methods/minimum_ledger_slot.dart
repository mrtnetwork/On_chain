import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';

/// Returns the lowest slot that the node has information about in its ledger.
/// This value may increase over time if the node is configured to purge older ledger data
/// https://solana.com/docs/rpc/http/minimumledgerslot
class SolanaRequestMinimumLedgerSlot extends SolanaRequest<int, int> {
  /// minimumLedgerSlot
  @override
  String get method => SolanaRequestMethods.minimumLedgerSlot.value;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
