import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/core_candy_machine/accounts/accounts.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

/// Retrieves the Core Candy Machine account info and
/// deserializes the [CoreCandyMachineAccount] from its data.
class SolanaRPCGetCoreCandyMachineAccount
    extends SolanaRequest<CoreCandyMachineAccount?, Map<String, dynamic>?> {
  const SolanaRPCGetCoreCandyMachineAccount({
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
  CoreCandyMachineAccount? onResponse(Map<String, dynamic>? result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return CoreCandyMachineAccount.fromBuffer(accountInfo.toBytesData());
  }
}
