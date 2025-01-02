import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

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

  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.blob(8, property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexFixedPriceSaleProgramInstruction get instruction =>
      MetaplexFixedPriceSaleProgramInstruction.suspendMarket;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
