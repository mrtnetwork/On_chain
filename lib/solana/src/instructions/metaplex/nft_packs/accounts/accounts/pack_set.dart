import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/types/types/account_type.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/types/types/pack_distribution_type.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/types/types/pack_set_state.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.u8("accountType"),
    LayoutUtils.publicKey("store"),
    LayoutUtils.publicKey("authority"),
    LayoutUtils.string("description"),
    LayoutUtils.string("uri"),
    LayoutUtils.blob(32, property: "name"),
    LayoutUtils.u32("packCards"),
    LayoutUtils.u32("packVouchers"),
    LayoutUtils.u64("totalWeight"),
    LayoutUtils.u64("totalEditions"),
    LayoutUtils.boolean(property: "mutable"),
    LayoutUtils.u8("packState"),
    LayoutUtils.u8("distributionType"),
    LayoutUtils.u32("allowedAmountToRedeem"),
    LayoutUtils.u64("redeemStartDate"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "redeemEndDate")
  ]);
}

class PackSet extends LayoutSerializable {
  final NFTPacksAccountType accountType;
  final SolAddress store;
  final SolAddress authority;
  final String description;
  final String uri;
  final List<int> name;
  final int packCards;
  final int packVouchers;
  final BigInt totalWeight;
  final BigInt totalEditions;
  final bool mutable;
  final PackSetState packState;
  final PackDistributionType distributionType;
  final int allowedAmountToRedeem;
  final BigInt redeemStartDate;
  final BigInt? redeemEndDate;
  const PackSet(
      {required this.accountType,
      required this.store,
      required this.authority,
      required this.description,
      required this.uri,
      required this.name,
      required this.packCards,
      required this.packVouchers,
      required this.totalWeight,
      required this.totalEditions,
      required this.mutable,
      required this.packState,
      required this.distributionType,
      required this.allowedAmountToRedeem,
      required this.redeemStartDate,
      this.redeemEndDate});
  factory PackSet.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return PackSet(
        accountType: NFTPacksAccountType.fromValue(decode["accountType"]),
        store: decode["store"],
        authority: decode["authority"],
        description: decode["description"],
        uri: decode["uri"],
        name: (decode["name"] as List).cast(),
        packCards: decode["packCards"],
        packVouchers: decode["packVouchers"],
        totalWeight: decode["totalWeight"],
        totalEditions: decode["totalEditions"],
        mutable: decode["mutable"],
        packState: PackSetState.fromValue(decode["packState"]),
        distributionType:
            PackDistributionType.fromValue(decode["distributionType"]),
        allowedAmountToRedeem: decode["allowedAmountToRedeem"],
        redeemStartDate: decode["redeemStartDate"],
        redeemEndDate: decode["redeemEndDate"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "accountType": accountType.value,
      "store": store,
      "authority": authority,
      "description": description,
      "uri": uri,
      "name": name,
      "packCards": packCards,
      "packVouchers": packVouchers,
      "totalWeight": totalWeight,
      "totalEditions": totalEditions,
      "mutable": mutable,
      "packState": packState.value,
      "distributionType": distributionType.value,
      "allowedAmountToRedeem": allowedAmountToRedeem,
      "redeemStartDate": redeemStartDate,
      "redeemEndDate": redeemEndDate,
    };
  }

  @override
  String toString() {
    return "PackSet${serialize()}";
  }
}
