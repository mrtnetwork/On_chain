import 'package:on_chain/solana/src/instructions/stake_pool/accounts/accounts.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

/// Retrieves and deserializes a Stake validator list account.
class SolanaRPCGetStakePoolValidatorListAccount
    extends SolanaRPCRequest<StakeValidatorListAccount?> {
  const SolanaRPCGetStakePoolValidatorListAccount({
    required this.address,
    Commitment? commitment,
    MinContextSlot? minContextSlot,
  }) : super(commitment: commitment, minContextSlot: minContextSlot);

  @override
  String get method => SolanaRPCMethods.getAccountInfo.value;
  final String address;

  @override
  List<dynamic> toJson() {
    return [
      address,
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        SolanaRPCEncoding.base64.toJson(),
        minContextSlot?.toJson()
      ])
    ];
  }

  @override
  StakeValidatorListAccount? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return StakeValidatorListAccount.fromBuffer(accountInfo.toBytesData());
  }
}
