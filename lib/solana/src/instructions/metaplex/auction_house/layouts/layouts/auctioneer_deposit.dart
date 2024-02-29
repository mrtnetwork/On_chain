import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexAuctionHouseAuctioneerDepositLayout
    extends MetaplexAuctionHouseProgramLayout {
  final int escrowPaymentBump;
  final BigInt amount;
  const MetaplexAuctionHouseAuctioneerDepositLayout(
      {required this.escrowPaymentBump, required this.amount});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseAuctioneerDepositLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctionHouseProgramInstruction
            .auctioneerDeposit.insturction);
    return MetaplexAuctionHouseAuctioneerDepositLayout(
        amount: decode["amount"],
        escrowPaymentBump: decode["escrowPaymentBump"]);
  }

  /// Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("escrowPaymentBump"),
    LayoutUtils.u64("amount"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexAuctionHouseProgramInstruction.auctioneerDeposit.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"amount": amount, "escrowPaymentBump": escrowPaymentBump};
  }
}
