import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/accounts/accounts/mint_account.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

class SolanaRPCGetMintAccount
    extends SolanaRequest<SolanaMintAccount?, Map<String, dynamic>?> {
  const SolanaRPCGetMintAccount({
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
  SolanaMintAccount? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);

    return SolanaMintAccount.fromBuffer(
        address: account, data: accountInfo.toBytesData());
  }
}
