import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/accounts/accounts.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

class SolanaRPCGetGroupMemberPointer
    extends SolanaRequest<GroupMemberPointer?, Map<String, dynamic>?> {
  const SolanaRPCGetGroupMemberPointer({
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
  GroupMemberPointer? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return GroupMemberPointer.fromBuffer(accountInfo.toBytesData());
  }
}
