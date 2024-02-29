import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/vote/accounts/accounts/vote_account.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

class SolanaRPCGetVoteAccount extends SolanaRPCRequest<VoteAccount?> {
  const SolanaRPCGetVoteAccount({
    required this.account,
    Commitment? commitment,
    MinContextSlot? minContextSlot,
  }) : super(commitment: commitment, minContextSlot: minContextSlot);

  @override
  String get method => SolanaRPCMethods.getAccountInfo.value;
  final SolAddress account;

  @override
  List<dynamic> toJson() {
    return [
      account,
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        SolanaRPCEncoding.base64.toJson(),
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
