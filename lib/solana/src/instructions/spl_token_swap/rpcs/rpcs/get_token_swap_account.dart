import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token_swap/accounts/accounts.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

class SolanaRPCSPLTokenSwapAccount
    extends SolanaRequest<SPLTokenSwapAccount?, Map<String, dynamic>?> {
  const SolanaRPCSPLTokenSwapAccount({
    required this.account,
    this.ownerProgramAddress,
    super.commitment,
    super.minContextSlot,
  });

  @override
  String get method => SolanaRequestMethods.getAccountInfo.value;
  final SolAddress account;
  final SolAddress? ownerProgramAddress;

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
  SPLTokenSwapAccount? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    if (ownerProgramAddress != null &&
        accountInfo.owner.address != ownerProgramAddress?.address) {
      throw SolanaPluginException('Invalid program address owner.', details: {
        'expected': ownerProgramAddress,
        'owner': accountInfo.owner.address
      });
    }
    return SPLTokenSwapAccount.fromBuffer(accountInfo.toBytesData());
  }
}
