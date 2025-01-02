import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/accounts/accounts.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

/// Retrieves the account info from the provided address and deserializes
/// the [ClaimStatus] from its data.
class SolanaRPCGetClaimStatusAccount
    extends SolanaRequest<ClaimStatus?, Map<String, dynamic>?> {
  const SolanaRPCGetClaimStatusAccount({
    required this.account,
    super.commitment,
    super.minContextSlot,
  });

  @override
  String get method => SolanaRequestMethods.getAccountInfo.value;
  final SolAddress account;

  @override
  List<dynamic> toJson() {
    return [
      account.address,
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        SolanaRequestEncoding.base64.toJson(),
        minContextSlot?.toJson()
      ])
    ];
  }

  @override
  ClaimStatus? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return ClaimStatus.fromBuffer(accountInfo.toBytesData());
  }
}
