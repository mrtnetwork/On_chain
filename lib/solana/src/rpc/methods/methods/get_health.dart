import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';

/// Returns the current health of the node. A healthy node is one that is within HEALTH_CHECK_SLOT_DISTANCE slots of the latest cluster confirmed slot.
/// https://solana.com/docs/rpc/http/gethealth
class SolanaRPCGetHealth extends SolanaRPCRequest<String> {
  /// getHealth
  @override
  String get method => SolanaRPCMethods.getHealth.value;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
