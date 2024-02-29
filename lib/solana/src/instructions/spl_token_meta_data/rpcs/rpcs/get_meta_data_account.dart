import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token_meta_data/accounts/accounts.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

/// Retrieves the account info from the provided address and deserializes
/// the [SPLTokenMetaDataAccount] from its data.
class SolanaRPCGetSPLTokenMetaDataAccount
    extends SolanaRPCRequest<SPLTokenMetaDataAccount?> {
  const SolanaRPCGetSPLTokenMetaDataAccount({
    required this.mintAddress,
    Commitment? commitment,
    MinContextSlot? minContextSlot,
  }) : super(commitment: commitment, minContextSlot: minContextSlot);

  @override
  String get method => SolanaRPCMethods.getAccountInfo.value;
  final SolAddress mintAddress;

  @override
  List<dynamic> toJson() {
    return [
      mintAddress.address,
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        SolanaRPCEncoding.base64.toJson(),
        minContextSlot?.toJson()
      ])
    ];
  }

  @override
  SPLTokenMetaDataAccount? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return SPLTokenMetaDataAccount.fromAccountDataBytes(
        accountInfo.toBytesData());
  }
}
