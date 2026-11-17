import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';

/// Returns the current health of the node. A healthy node is one that is within HEALTH_CHECK_SLOT_DISTANCE slots of the latest cluster confirmed slot.
/// https://solana.com/docs/rpc/http/gethealth
class SolanaRequestGetHealth extends SolanaRequest<String, String> {
  /// getHealth
  @override
  String get method => SolanaRequestMethods.getHealth.value;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
