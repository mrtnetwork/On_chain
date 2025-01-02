import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/accounts/accounts/token_account.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

class SolanaRPCGetTokenAccount
    extends SolanaRequest<SolanaTokenAccount?, Map<String, dynamic>?> {
  const SolanaRPCGetTokenAccount({
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
  SolanaTokenAccount? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return SolanaTokenAccount.fromBuffer(
        address: account, data: accountInfo.toBytesData());
  }
}
