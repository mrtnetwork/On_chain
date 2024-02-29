import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';

/// Get the max slot seen from after shred insert.
/// https://solana.com/docs/rpc/http/getmaxshredinsertslot
class SolanaRPCGetMaxShredInsertSlot extends SolanaRPCRequest<int> {
  /// getMaxShredInsertSlot
  @override
  String get method => SolanaRPCMethods.getMaxShredInsertSlot.value;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
