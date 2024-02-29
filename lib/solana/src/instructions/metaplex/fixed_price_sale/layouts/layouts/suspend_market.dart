import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexFixedPriceSaleSuspendMarketLayout
    extends MetaplexFixedPriceSaleProgramLayout {
  MetaplexFixedPriceSaleSuspendMarketLayout();

  factory MetaplexFixedPriceSaleSuspendMarketLayout.fromBuffer(List<int> data) {
    MetaplexFixedPriceSaleProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexFixedPriceSaleProgramInstruction.suspendMarket.insturction);
    return MetaplexFixedPriceSaleSuspendMarketLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.blob(8, property: "instruction")]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexFixedPriceSaleProgramInstruction.suspendMarket.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
