import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/vote/accounts/accounts/vote_account.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

class SolanaRPCGetVoteAccount
    extends SolanaRequest<VoteAccount?, Map<String, dynamic>?> {
  const SolanaRPCGetVoteAccount({
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
      account,
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        SolanaRequestEncoding.base64.toJson(),
        minContextSlot?.toJson()
      ])
    ];
  }

  @override
  VoteAccount? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    final accountDataBytes = accountInfo.toBytesData();
    return VoteAccount.fromBuffer(accountDataBytes);
  }
}
