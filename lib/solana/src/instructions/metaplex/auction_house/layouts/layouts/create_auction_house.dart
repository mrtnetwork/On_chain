import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

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

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u8(property: "bump"),
    LayoutConst.u8(property: "feePayerBump"),
    LayoutConst.u8(property: "treasuryBump"),
    LayoutConst.u16(property: "sellerFeeBasisPoints"),
    LayoutConst.boolean(property: "requiresSignOff"),
    LayoutConst.boolean(property: "canChangeSalePrice"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexAuctionHouseProgramInstruction get instruction =>
      MetaplexAuctionHouseProgramInstruction.createAuctionHouse;

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
