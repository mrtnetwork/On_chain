import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexFixedPriceSaleCloseMarketLayout
    extends MetaplexFixedPriceSaleProgramLayout {
  MetaplexFixedPriceSaleCloseMarketLayout();

  factory MetaplexFixedPriceSaleCloseMarketLayout.fromBuffer(List<int> data) {
    MetaplexFixedPriceSaleProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexFixedPriceSaleProgramInstruction.closeMarket.insturction);
    return MetaplexFixedPriceSaleCloseMarketLayout();
  }

  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.blob(8, property: "instruction")]);

  @override
  StructLayout get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexFixedPriceSaleProgramInstruction.closeMarket.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
