import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/accounts/accounts.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

/// Retrieves the account info from the provided address and deserializes
/// the [AllowListProofAccount] from its data.
class SolanaRPCGetAllowListProofAccount
    extends SolanaRequest<AllowListProofAccount?, Map<String, dynamic>?> {
  const SolanaRPCGetAllowListProofAccount({
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
  AllowListProofAccount? onResonse(Map<String, dynamic>? result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return AllowListProofAccount.fromBuffer(accountInfo.toBytesData());
  }
}
