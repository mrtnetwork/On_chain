import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/accounts/accounts.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

/// Retrieves the account info from the provided address and deserializes
/// the [CollectionAuthorityRecord] from its data.
class SolanaRPCGetCollectionAuthorityRecordAccount
    extends SolanaRequest<CollectionAuthorityRecord?, Map<String, dynamic>?> {
  const SolanaRPCGetCollectionAuthorityRecordAccount({
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
  CollectionAuthorityRecord? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return CollectionAuthorityRecord.fromBuffer(accountInfo.toBytesData());
  }
}
