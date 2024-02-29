import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexAuctionHouseCreateAuctionHouseLayout
    extends MetaplexAuctionHouseProgramLayout {
  final int bump;
  final int feePayerBump;
  final int treasuryBump;
  final int sellerFeeBasisPoints;
  final bool requiresSignOff;
  final bool canChangeSalePrice;
  const MetaplexAuctionHouseCreateAuctionHouseLayout(
      {required this.feePayerBump,
      required this.treasuryBump,
      required this.sellerFeeBasisPoints,
      required this.requiresSignOff,
      required this.canChangeSalePrice,
      required this.bump});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseCreateAuctionHouseLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction
            .createAuctionHouse.insturction);
    return MetaplexAuctionHouseCreateAuctionHouseLayout(
        feePayerBump: decode["feePayerBump"],
        bump: decode["bump"],
        treasuryBump: decode["treasuryBump"],
        sellerFeeBasisPoints: decode["sellerFeeBasisPoints"],
        requiresSignOff: decode["requiresSignOff"],
        canChangeSalePrice: decode["canChangeSalePrice"]);
  }

  /// Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("bump"),
    LayoutUtils.u8("feePayerBump"),
    LayoutUtils.u8("treasuryBump"),
    LayoutUtils.u16("sellerFeeBasisPoints"),
    LayoutUtils.boolean(property: "requiresSignOff"),
    LayoutUtils.boolean(property: "canChangeSalePrice"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexAuctionHouseProgramInstruction.createAuctionHouse.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "feePayerBump": feePayerBump,
      "treasuryBump": treasuryBump,
      "sellerFeeBasisPoints": sellerFeeBasisPoints,
      "requiresSignOff": requiresSignOff,
      "canChangeSalePrice": canChangeSalePrice,
      "bump": bump
    };
  }
}
