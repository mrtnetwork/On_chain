import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexAuctionHouseCloseEscrowAccountLayout
    extends MetaplexAuctionHouseProgramLayout {
  final int escrowPaymentBump;
  const MetaplexAuctionHouseCloseEscrowAccountLayout(
      {required this.escrowPaymentBump});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseCloseEscrowAccountLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction
            .closeEscrowAccount.insturction);
    return MetaplexAuctionHouseCloseEscrowAccountLayout(
        escrowPaymentBump: decode["escrowPaymentBump"]);
  }

  /// Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("escrowPaymentBump"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexAuctionHouseProgramInstruction.closeEscrowAccount.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"escrowPaymentBump": escrowPaymentBump};
  }
}
