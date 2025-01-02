import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/accounts/accounts.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

/// Retrieves the account info from the provided address and deserializes
/// the [TreeConfig] from its data.
class SolanaRPCGetTreeConfigAccount
    extends SolanaRequest<TreeConfig?, Map<String, dynamic>?> {
  const SolanaRPCGetTreeConfigAccount({
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
  TreeConfig? onResonse(Map<String, dynamic>? result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return TreeConfig.fromBuffer(accountInfo.toBytesData());
  }
}
