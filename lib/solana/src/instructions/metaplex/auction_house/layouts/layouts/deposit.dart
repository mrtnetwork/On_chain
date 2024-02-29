import 'package:on_chain/solana/src/instructions/metaplex/auction_house/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexAuctionHouseDepositLayout
    extends MetaplexAuctionHouseProgramLayout {
  final int escrowPaymentBump;
  final BigInt amount;
  const MetaplexAuctionHouseDepositLayout(
      {required this.escrowPaymentBump, required this.amount});

  /// Constructs the layout from raw bytes.
  factory MetaplexAuctionHouseDepositLayout.fromBuffer(List<int> data) {
    final decode = MetaplexAuctionHouseProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexAuctionHouseProgramInstruction.deposit.insturction);
    return MetaplexAuctionHouseDepositLayout(
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
      MetaplexAuctionHouseProgramInstruction.deposit.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"amount": amount, "escrowPaymentBump": escrowPaymentBump};
  }
}
