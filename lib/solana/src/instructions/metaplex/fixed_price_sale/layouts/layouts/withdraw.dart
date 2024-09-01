import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

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

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u8(property: "treasuryOwnerBump"),
    LayoutConst.u8(property: "payoutTicketBump")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexFixedPriceSaleProgramInstruction get instruction =>
      MetaplexFixedPriceSaleProgramInstruction.withdraw;

  @override
  Map<String, dynamic> serialize() {
    return {
      "treasuryOwnerBump": treasuryOwnerBump,
      "payoutTicketBump": payoutTicketBump
    };
  }
}
