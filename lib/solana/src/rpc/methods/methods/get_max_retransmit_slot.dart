import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';

/// Get the max slot seen from retransmit stage.
/// https://solana.com/docs/rpc/http/getmaxretransmitslot
class SolanaRequestGetMaxRetransmitSlot extends SolanaRequest<int, int> {
  /// getMaxRetransmitSlot
  @override
  String get method => SolanaRequestMethods.getMaxRetransmitSlot.value;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
