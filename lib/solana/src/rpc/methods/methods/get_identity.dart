import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';

/// Returns the identity pubkey for the current node
/// https://solana.com/docs/rpc/http/getidentity
class SolanaRequestGetIdentity
    extends SolanaRequest<Map<String, dynamic>, Map<String, dynamic>> {
  /// getIdentity
  @override
  String get method => SolanaRequestMethods.getIdentity.value;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
