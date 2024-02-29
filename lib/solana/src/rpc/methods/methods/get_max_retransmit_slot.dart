import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';

/// Get the max slot seen from retransmit stage.
/// https://solana.com/docs/rpc/http/getmaxretransmitslot
class SolanaRPCGetMaxRetransmitSlot extends SolanaRPCRequest<int> {
  /// getMaxRetransmitSlot
  @override
  String get method => SolanaRPCMethods.getMaxRetransmitSlot.value;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
