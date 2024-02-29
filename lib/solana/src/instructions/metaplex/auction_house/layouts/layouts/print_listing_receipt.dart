import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexAuctionHousePrintListingReceiptLayout
    extends MetaplexAuctionHouseProgramLayout {
  final int receiptBump;

  const MetaplexAuctionHousePrintListingReceiptLayout(
      {required this.receiptBump});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHousePrintListingReceiptLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction
            .printListingReceipt.insturction);
    return MetaplexAuctionHousePrintListingReceiptLayout(
        receiptBump: decode["receiptBump"]);
  }

  /// Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("receiptBump"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexAuctionHouseProgramInstruction.printListingReceipt.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"receiptBump": receiptBump};
  }
}
