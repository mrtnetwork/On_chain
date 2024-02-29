import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexAuctionHousePrintBidReceiptLayout
    extends MetaplexAuctionHouseProgramLayout {
  final int receiptBump;
  const MetaplexAuctionHousePrintBidReceiptLayout({required this.receiptBump});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHousePrintBidReceiptLayout.fromBuffer(List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexAuctionHouseProgramInstruction.printBidReceipt.insturction);
    return MetaplexAuctionHousePrintBidReceiptLayout(
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
      MetaplexAuctionHouseProgramInstruction.printBidReceipt.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"receiptBump": receiptBump};
  }
}
