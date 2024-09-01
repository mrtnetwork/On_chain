import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexAuctionHousePrintPurchaseReceiptLayout
    extends MetaplexAuctionHouseProgramLayout {
  final int purchaseReceiptBump;
  const MetaplexAuctionHousePrintPurchaseReceiptLayout(
      {required this.purchaseReceiptBump});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHousePrintPurchaseReceiptLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction
            .printPurchaseReceipt.insturction);
    return MetaplexAuctionHousePrintPurchaseReceiptLayout(
        purchaseReceiptBump: decode["purchaseReceiptBump"]);
  }

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u8(property: "purchaseReceiptBump"),
  ]);
  @override
  StructLayout get layout => _layout;

  @override
  MetaplexAuctionHouseProgramInstruction get instruction =>
      MetaplexAuctionHouseProgramInstruction.printPurchaseReceipt;

  @override
  Map<String, dynamic> serialize() {
    return {"purchaseReceiptBump": purchaseReceiptBump};
  }
}
