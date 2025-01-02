import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

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
        receiptBump: decode['receiptBump']);
  }

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.u8(property: 'receiptBump'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexAuctionHouseProgramInstruction get instruction =>
      MetaplexAuctionHouseProgramInstruction.printBidReceipt;

  @override
  Map<String, dynamic> serialize() {
    return {'receiptBump': receiptBump};
  }
}
