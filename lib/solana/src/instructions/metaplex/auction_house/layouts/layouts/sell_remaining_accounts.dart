import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexAuctionHouseSellRemainingAccountsLayout
    extends MetaplexAuctionHouseProgramLayout {
  const MetaplexAuctionHouseSellRemainingAccountsLayout();

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseSellRemainingAccountsLayout.fromBuffer(
      List<int> data) {
    MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction
            .sellRemainingAccounts.insturction);
    return MetaplexAuctionHouseSellRemainingAccountsLayout();
  }

  /// Structure layout definition.
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.blob(8, property: "instruction")]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexAuctionHouseProgramInstruction.sellRemainingAccounts.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
