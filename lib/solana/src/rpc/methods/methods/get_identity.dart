import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';

/// Returns the identity pubkey for the current node
/// https://solana.com/docs/rpc/http/getidentity
class SolanaRPCGetIdentity extends SolanaRPCRequest<Map<String, dynamic>> {
  /// getIdentity
  @override
  String get method => SolanaRPCMethods.getIdentity.value;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
