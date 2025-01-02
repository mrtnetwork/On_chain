import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/name_service/accounts/accounts.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

/// Retrieves the account info from the provided address and deserializes
/// the [ReverseTwitterRegistryAccount] from its data.
class SolanaRPCReverseTwitterRegistryAccount extends SolanaRequest<
    ReverseTwitterRegistryAccount?, Map<String, dynamic>?> {
  const SolanaRPCReverseTwitterRegistryAccount({
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
  ReverseTwitterRegistryAccount? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return ReverseTwitterRegistryAccount.fromAccountBytes(
        accountInfo.toBytesData());
  }
}
