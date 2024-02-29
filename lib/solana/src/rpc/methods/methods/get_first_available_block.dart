import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';

/// Returns the slot of the lowest confirmed block that has not been purged from the ledger
/// https://solana.com/docs/rpc/http/getfirstavailableblock
class SolanaRPCGetFirstAvailableBlock extends SolanaRPCRequest<int> {
  /// getFirstAvailableBlock
  @override
  String get method => SolanaRPCMethods.getFirstAvailableBlock.value;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
