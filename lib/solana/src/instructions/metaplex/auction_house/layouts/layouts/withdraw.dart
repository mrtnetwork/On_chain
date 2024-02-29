import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexAuctionHouseWithdrawLayout
    extends MetaplexAuctionHouseProgramLayout {
  final BigInt amount;
  final int escrowPaymentBump;
  const MetaplexAuctionHouseWithdrawLayout(
      {required this.amount, required this.escrowPaymentBump});

  factory MetaplexAuctionHouseWithdrawLayout.fromBuffer(List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexAuctionHouseProgramInstruction.withdraw.insturction);
    return MetaplexAuctionHouseWithdrawLayout(
        amount: decode["amount"],
        escrowPaymentBump: decode["escrowPaymentBump"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("escrowPaymentBump"),
    LayoutUtils.u64("amount"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexAuctionHouseProgramInstruction.withdraw.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"escrowPaymentBump": escrowPaymentBump, "amount": amount};
  }
}
