import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/accounts/accounts/permanent_delegate.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

class SolanaRPCGetPermanentDelegate
    extends SolanaRequest<PermanentDelegate?, Map<String, dynamic>?> {
  const SolanaRPCGetPermanentDelegate({
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
  PermanentDelegate? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return PermanentDelegate.fromAccountBytes(accountInfo.toBytesData());
  }
}
