import 'package:on_chain/solana/src/instructions/stake_pool/accounts/accounts.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

/// Retrieves and deserializes a Stake validator list account.
class SolanaRPCGetStakePoolValidatorListAccount
    extends SolanaRequest<StakeValidatorListAccount?, Map<String, dynamic>?> {
  const SolanaRPCGetStakePoolValidatorListAccount({
    required this.address,
    super.commitment,
    super.minContextSlot,
  });

  @override
  String get method => SolanaRequestMethods.getAccountInfo.value;
  final String address;

  @override
  List<dynamic> toJson() {
    return [
      address,
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        SolanaRequestEncoding.base64.toJson(),
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
