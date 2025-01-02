import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/stake_pool/accounts/accounts/stake_pool.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

/// Retrieves and deserializes a StakePool account.
class SolanaRPCGetStakePoolAccount
    extends SolanaRequest<StakePoolAccount?, Map<String, dynamic>?> {
  const SolanaRPCGetStakePoolAccount({
    required this.address,
    super.commitment,
    super.minContextSlot,
  });

  @override
  String get method => SolanaRequestMethods.getAccountInfo.value;
  final SolAddress address;

  @override
  List<dynamic> toJson() {
    return [
      address.address,
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        SolanaRequestEncoding.base64.toJson(),
        minContextSlot?.toJson()
      ])
    ];
  }

  @override
  StakePoolAccount? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return StakePoolAccount.fromBuffer(
        data: accountInfo.toBytesData(), address: address);
  }
}
