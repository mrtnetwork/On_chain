import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexFixedPriceSaleWithdrawLayout
    extends MetaplexFixedPriceSaleProgramLayout {
  MetaplexFixedPriceSaleWithdrawLayout(
      {required this.treasuryOwnerBump, required this.payoutTicketBump});

  /// Constructs the layout from raw bytes.
  factory MetaplexFixedPriceSaleWithdrawLayout.fromBuffer(List<int> data) {
    final decode = MetaplexFixedPriceSaleProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexFixedPriceSaleProgramInstruction.withdraw.insturction);
    return MetaplexFixedPriceSaleWithdrawLayout(
        treasuryOwnerBump: decode["treasuryOwnerBump"],
        payoutTicketBump: decode["payoutTicketBump"]);
  }
  final int treasuryOwnerBump;
  final int payoutTicketBump;

  /// Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("treasuryOwnerBump"),
    LayoutUtils.u8("payoutTicketBump")
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexFixedPriceSaleProgramInstruction.withdraw.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "treasuryOwnerBump": treasuryOwnerBump,
      "payoutTicketBump": payoutTicketBump
    };
  }
}
