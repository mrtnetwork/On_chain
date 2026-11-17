import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';

/// Returns the identity pubkey for the current node
/// https://solana.com/docs/rpc/http/getidentity
class SolanaRequestGetIdentity
    extends SolanaRequest<SolanaIdentityResponse, Map<String, dynamic>> {
  /// getIdentity
  @override
  String get method => SolanaRequestMethods.getIdentity.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  SolanaIdentityResponse onResponse(Map<String, dynamic> result) {
    return SolanaIdentityResponse.fromJson(result);
  }
}
