import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexAuctionHouseCancelListingReceiptLayout
    extends MetaplexAuctionHouseProgramLayout {
  const MetaplexAuctionHouseCancelListingReceiptLayout();

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseCancelListingReceiptLayout.fromBuffer(
      List<int> data) {
    MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction
            .cancelListingReceipt.insturction);
    return const MetaplexAuctionHouseCancelListingReceiptLayout();
  }

  /// StructLayout layout definition.
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.blob(8, property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexAuctionHouseProgramInstruction get instruction =>
      MetaplexAuctionHouseProgramInstruction.cancelListingReceipt;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
