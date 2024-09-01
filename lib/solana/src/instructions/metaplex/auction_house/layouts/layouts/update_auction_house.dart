import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

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

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.optional(LayoutConst.u16(), property: "sellerFeeBasisPoints"),
    LayoutConst.optional(LayoutConst.boolean(), property: "requiresSignOff"),
    LayoutConst.optional(LayoutConst.boolean(), property: "canChangeSalePrice"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexAuctionHouseProgramInstruction get instruction =>
      MetaplexAuctionHouseProgramInstruction.updateAuctionHouse;

  @override
  Map<String, dynamic> serialize() {
    return {
      "sellerFeeBasisPoints": sellerFeeBasisPoints,
      "requiresSignOff": requiresSignOff,
      "canChangeSalePrice": canChangeSalePrice
    };
  }
}
