import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/accounts/accounts.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

class SolanaRPCGetGroupPointer
    extends SolanaRequest<GroupPointer?, Map<String, dynamic>?> {
  const SolanaRPCGetGroupPointer({
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
  GroupPointer? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return GroupPointer.fromBuffer(accountInfo.toBytesData());
  }
}
