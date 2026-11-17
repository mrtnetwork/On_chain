import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/mpl_core/accounts.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

/// Retrieves the MPL Core asset account info and deserializes
/// the [MplCoreAssetAccount] from its data.
class SolanaRPCGetMplCoreAssetAccount
    extends SolanaRequest<MplCoreAssetAccount?, Map<String, dynamic>?> {
  const SolanaRPCGetMplCoreAssetAccount({
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
        minContextSlot?.toJson(),
      ]),
    ];
  }

  @override
  MplCoreAssetAccount? onResponse(Map<String, dynamic>? result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return MplCoreAssetAccount.fromBuffer(accountInfo.toBytesData());
  }
}
