import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the statuses of a list of signatures. Each signature must be a txid, the first signature of a transaction.
/// Unless the searchTransactionHistory configuration parameter is included,
/// this method only searches the recent status cache of signatures,
/// which retains statuses for all active slots plus MAX_RECENT_BLOCKHASHES rooted slots.
///
/// https://solana.com/docs/rpc/http/getsignaturestatuses
class SolanaRPCGetSignatureStatuses
    extends SolanaRPCRequest<List<SignatureStatus?>> {
  const SolanaRPCGetSignatureStatuses({
    this.signatures,
    this.searchTransactionHistory,
  });

  /// getSignatureStatuses
  @override
  String get method => SolanaRPCMethods.getSignatureStatuses.value;

  /// An array of transaction signatures to confirm, as base-58 encoded strings (up to a maximum of 256)
  final List<String>? signatures;

  /// if true - a Solana node will search its ledger cache for any signatures not found in the recent status cache
  final bool? searchTransactionHistory;

  @override
  List<dynamic> toJson() {
    return [
      signatures,
      SolanaRPCUtils.createConfig([
        {"searchTransactionHistory": searchTransactionHistory}
      ])
    ];
  }

  @override
  List<SignatureStatus?> onResonse(result) {
    return (result as List)
        .map((e) => e == null ? null : SignatureStatus.fromJson(e))
        .toList();
  }
}
