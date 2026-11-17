import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/encoding/encoding.dart';

class MetaplexFixedPriceSaleResumeMarketLayout
    extends MetaplexFixedPriceSaleProgramLayout {
  MetaplexFixedPriceSaleResumeMarketLayout();

  factory MetaplexFixedPriceSaleResumeMarketLayout.fromBuffer(List<int> data) {
    MetaplexFixedPriceSaleProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: data,
      instruction:
          MetaplexFixedPriceSaleProgramInstruction.resumeMarket.instruction,
    );
    return MetaplexFixedPriceSaleResumeMarketLayout();
  }

  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.blob(8, property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexFixedPriceSaleProgramInstruction get instruction =>
      MetaplexFixedPriceSaleProgramInstruction.resumeMarket;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
