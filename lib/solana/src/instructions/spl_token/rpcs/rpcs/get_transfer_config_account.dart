import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token/spl_token.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

class SolanaRPCGetTransferFeeConfigAccount
    extends SolanaRequest<TransferFeeConfig?, Map<String, dynamic>?> {
  const SolanaRPCGetTransferFeeConfigAccount({
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
  TransferFeeConfig? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return TransferFeeConfig.fromAccountBytes(accountInfo.toBytesData());
  }
}
