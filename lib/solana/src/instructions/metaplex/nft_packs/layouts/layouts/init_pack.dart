import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/nft_packs/types/types/pack_distribution_type.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexNFTPacksInitPackLayout extends MetaplexNFTPacksProgramLayout {
  final List<int> name;
  final String description;
  final String uri;
  final bool mutable;
  final PackDistributionType packDistributionType;
  final int allowedAmountToRedeem;
  final BigInt? redeemStartDate;
  final BigInt? redeemEndDate;
  MetaplexNFTPacksInitPackLayout(
      {required List<int> name,
      required this.description,
      required this.uri,
      required this.mutable,
      required this.packDistributionType,
      required this.allowedAmountToRedeem,
      this.redeemStartDate,
      this.redeemEndDate})
      : name = BytesUtils.toBytes(name, unmodifiable: true);

  factory MetaplexNFTPacksInitPackLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexNFTPacksProgramInstruction.initPack.insturction);
    return MetaplexNFTPacksInitPackLayout(
        name: decode["name"],
        description: decode["description"],
        uri: decode["uri"],
        mutable: decode["mutable"],
        packDistributionType:
            PackDistributionType.fromValue(decode["distributionType"]),
        allowedAmountToRedeem: decode["allowedAmountToRedeem"],
        redeemStartDate: decode["redeemStartDate"],
        redeemEndDate: decode["redeemEndDate"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.blob(32, property: "name"),
    LayoutUtils.string("description"),
    LayoutUtils.string("uri"),
    LayoutUtils.boolean(property: "mutable"),
    LayoutUtils.u8("distributionType"),
    LayoutUtils.u32("allowedAmountToRedeem"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "redeemStartDate"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "redeemEndDate"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexNFTPacksProgramInstruction.initPack.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "name": name,
      "description": description,
      "uri": uri,
      "mutable": mutable,
      "distributionType": packDistributionType.value,
      "allowedAmountToRedeem": allowedAmountToRedeem,
      "redeemStartDate": redeemStartDate,
      "redeemEndDate": redeemEndDate
    };
  }
}
