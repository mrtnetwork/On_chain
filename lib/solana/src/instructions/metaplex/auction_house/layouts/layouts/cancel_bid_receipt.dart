import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

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
    return const MetaplexAuctionHouseCancelBidReceiptLayout();
  }

  /// StructLayout layout definition.
  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.blob(8, property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexAuctionHouseProgramInstruction get instruction =>
      MetaplexAuctionHouseProgramInstruction.cancelBidReceipt;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
