import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';

/// Get the max slot seen from after shred insert.
/// https://solana.com/docs/rpc/http/getmaxshredinsertslot
class SolanaRequestGetMaxShredInsertSlot extends SolanaRequest<int, int> {
  /// getMaxShredInsertSlot
  @override
  String get method => SolanaRequestMethods.getMaxShredInsertSlot.value;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
