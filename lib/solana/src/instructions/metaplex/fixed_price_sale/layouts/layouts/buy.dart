import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexFixedPriceSaleBuyLayout
    extends MetaplexFixedPriceSaleProgramLayout {
  final int tradeHistoryBump;
  final int vaultOwnerBump;
  const MetaplexFixedPriceSaleBuyLayout(
      {required this.tradeHistoryBump, required this.vaultOwnerBump});

  factory MetaplexFixedPriceSaleBuyLayout.fromBuffer(List<int> data) {
    final decode = MetaplexFixedPriceSaleProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexFixedPriceSaleProgramInstruction.buy.insturction);
    return MetaplexFixedPriceSaleBuyLayout(
        tradeHistoryBump: decode["tradeHistoryBump"],
        vaultOwnerBump: decode["vaultOwnerBump"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("tradeHistoryBump"),
    LayoutUtils.u8("vaultOwnerBump"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexFixedPriceSaleProgramInstruction.buy.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "tradeHistoryBump": tradeHistoryBump,
      "vaultOwnerBump": vaultOwnerBump
    };
  }
}
