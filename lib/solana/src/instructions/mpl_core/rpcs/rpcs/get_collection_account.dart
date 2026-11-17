import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/mpl_core/accounts.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

/// Retrieves the MPL Core collection account info and
/// deserializes the [MplCoreCollectionAccount] from its data.
class SolanaRPCGetMplCoreCollectionAccount
    extends SolanaRequest<MplCoreCollectionAccount?, Map<String, dynamic>?> {
  const SolanaRPCGetMplCoreCollectionAccount({
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
  MplCoreCollectionAccount? onResponse(Map<String, dynamic>? result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return MplCoreCollectionAccount.fromBuffer(accountInfo.toBytesData());
  }
}
