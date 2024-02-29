import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexAuctionHouseCancelBidReceiptLayout
    extends MetaplexAuctionHouseProgramLayout {
  const MetaplexAuctionHouseCancelBidReceiptLayout();

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseCancelBidReceiptLayout.fromBuffer(
      List<int> data) {
    MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction
            .cancelBidReceipt.insturction);
    return MetaplexAuctionHouseCancelBidReceiptLayout();
  }

  /// Structure layout definition.
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.blob(8, property: "instruction")]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexAuctionHouseProgramInstruction.cancelBidReceipt.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
