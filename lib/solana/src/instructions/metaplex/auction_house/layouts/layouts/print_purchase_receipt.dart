import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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

  /// Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("purchaseReceiptBump"),
  ]);
  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexAuctionHouseProgramInstruction.printPurchaseReceipt.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"purchaseReceiptBump": purchaseReceiptBump};
  }
}
