import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/address_lockup_table/address_lockup.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

class SolanaRPCGetAccountLookupAddres
    extends SolanaRequest<AddressLookupTableAccount?, Map<String, dynamic>?> {
  const SolanaRPCGetAccountLookupAddres({
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
  AddressLookupTableAccount? onResonse(Map<String, dynamic>? result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return AddressLookupTableAccount.fromBuffer(
        accountKey: account, accountData: accountInfo.toBytesData());
  }
}
