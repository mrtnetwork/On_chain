import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexAuctionHouseUpdateAuctionHouseLayout
    extends MetaplexAuctionHouseProgramLayout {
  final int? sellerFeeBasisPoints;
  final bool? requiresSignOff;
  final bool? canChangeSalePrice;
  const MetaplexAuctionHouseUpdateAuctionHouseLayout(
      {this.sellerFeeBasisPoints,
      this.requiresSignOff,
      this.canChangeSalePrice});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseUpdateAuctionHouseLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction
            .updateAuctionHouse.insturction);
    return MetaplexAuctionHouseUpdateAuctionHouseLayout(
        canChangeSalePrice: decode["canChangeSalePrice"],
        requiresSignOff: decode["requiresSignOff"],
        sellerFeeBasisPoints: decode["sellerFeeBasisPoints"]);
  }

  /// Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.optional(LayoutUtils.u16(), property: "sellerFeeBasisPoints"),
    LayoutUtils.optional(LayoutUtils.boolean(), property: "requiresSignOff"),
    LayoutUtils.optional(LayoutUtils.boolean(), property: "canChangeSalePrice"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexAuctionHouseProgramInstruction.updateAuctionHouse.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "sellerFeeBasisPoints": sellerFeeBasisPoints,
      "requiresSignOff": requiresSignOff,
      "canChangeSalePrice": canChangeSalePrice
    };
  }
}
