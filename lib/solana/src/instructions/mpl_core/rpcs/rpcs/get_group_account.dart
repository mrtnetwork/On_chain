import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/mpl_core/accounts.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

/// Retrieves the MPL Core group account info and deserializes
/// the [MplCoreGroupAccount] from its data.
class SolanaRPCGetMplCoreGroupAccount
    extends SolanaRequest<MplCoreGroupAccount?, Map<String, dynamic>?> {
  const SolanaRPCGetMplCoreGroupAccount({
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
  MplCoreGroupAccount? onResponse(Map<String, dynamic>? result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return MplCoreGroupAccount.fromBuffer(accountInfo.toBytesData());
  }
}
