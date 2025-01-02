import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

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
      MetaplexAuctionHouseProgramInstruction.printListingReceipt;

  @override
  Map<String, dynamic> serialize() {
    return {'receiptBump': receiptBump};
  }
}
