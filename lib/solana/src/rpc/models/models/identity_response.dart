import 'package:on_chain/solana/src/address/sol_address.dart';

/// Identity pubkey of the current node (getIdentity).
class SolanaIdentityResponse {
  const SolanaIdentityResponse({required this.identity});
  factory SolanaIdentityResponse.fromJson(Map<String, dynamic> json) {
    return SolanaIdentityResponse(
      identity: SolAddress.uncheckCurve(json['identity']),
    );
  }
  Map<String, dynamic> toJson() {
    return {'identity': identity.address};
  }

  /// Identity pubkey for the current node.
  final SolAddress identity;
}
