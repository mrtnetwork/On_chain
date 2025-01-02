import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/accounts/accounts/cip_guard.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

class SolanaRPCGetCipGuard
    extends SolanaRequest<CpiGuard?, Map<String, dynamic>?> {
  const SolanaRPCGetCipGuard({
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
  CpiGuard? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return CpiGuard.fromAccountBytes(accountInfo.toBytesData());
  }
}
