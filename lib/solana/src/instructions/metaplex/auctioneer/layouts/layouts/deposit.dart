import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// auctioneer deposit layout
class MetaplexAuctioneerDepositLayout extends MetaplexAuctioneerProgramLayout {
  final int escrowPaymentBump;
  final int auctioneerAuthorityBump;
  final BigInt amount;
  const MetaplexAuctioneerDepositLayout(
      {required this.escrowPaymentBump,
      required this.auctioneerAuthorityBump,
      required this.amount});

  factory MetaplexAuctioneerDepositLayout.fromBuffer(List<int> data) {
    final decode = MetaplexAuctioneerProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctioneerProgramInstruction.deposit.insturction);
    return MetaplexAuctioneerDepositLayout(
        amount: decode["amount"],
        auctioneerAuthorityBump: decode["auctioneerAuthorityBump"],
        escrowPaymentBump: decode["escrowPaymentBump"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("escrowPaymentBump"),
    LayoutUtils.u8("auctioneerAuthorityBump"),
    LayoutUtils.u64("amount"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexAuctioneerProgramInstruction.deposit.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "escrowPaymentBump": escrowPaymentBump,
      "auctioneerAuthorityBump": auctioneerAuthorityBump,
      "amount": amount
    };
  }
}
