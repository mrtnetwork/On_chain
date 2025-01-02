import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/auction_house.dart';
import 'package:on_chain/solana/src/rpc/rpc.dart';

/// Retrieves the account info from the provided address and deserializes
/// the [AuctionHouse] from its data.
class SolanaRPCGetAuctionHouseAccount
    extends SolanaRequest<AuctionHouse?, Map<String, dynamic>?> {
  const SolanaRPCGetAuctionHouseAccount({
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
  AuctionHouse? onResonse(Map<String, dynamic>? result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return AuctionHouse.fromBuffer(accountInfo.toBytesData());
  }
}
