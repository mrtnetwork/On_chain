import 'package:on_chain/solana/src/instructions/metaplex/auctioneer/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// auctioneer withdraw layout.
class MetaplexAuctioneerWithdrawLayout extends MetaplexAuctioneerProgramLayout {
  final int escrowPaymentBump;
  final int auctioneerAuthorityBump;
  final BigInt amount;
  const MetaplexAuctioneerWithdrawLayout(
      {required this.escrowPaymentBump,
      required this.auctioneerAuthorityBump,
      required this.amount});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctioneerWithdrawLayout.fromBuffer(List<int> data) {
    final decode = MetaplexAuctioneerProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexAuctioneerProgramInstruction.withdraw.insturction);
    return MetaplexAuctioneerWithdrawLayout(
        escrowPaymentBump: decode["escrowPaymentBump"],
        auctioneerAuthorityBump: decode["auctioneerAuthorityBump"],
        amount: decode["amount"]);
  }

  /// Structure layout definition.
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
      MetaplexAuctioneerProgramInstruction.withdraw.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "escrowPaymentBump": escrowPaymentBump,
      "auctioneerAuthorityBump": auctioneerAuthorityBump,
      "amount": amount
    };
  }
}
