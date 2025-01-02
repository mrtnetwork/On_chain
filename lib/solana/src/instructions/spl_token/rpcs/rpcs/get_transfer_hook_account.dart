import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/accounts/accounts/transfer_hook_account.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

class SolanaRPCGetTransferHookAccount
    extends SolanaRequest<TransferHookAccount?, Map<String, dynamic>?> {
  const SolanaRPCGetTransferHookAccount({
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
  TransferHookAccount? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return TransferHookAccount.fromAccountBytes(accountInfo.toBytesData());
  }
}
