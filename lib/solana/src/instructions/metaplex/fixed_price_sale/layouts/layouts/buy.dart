import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

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
        tradeHistoryBump: decode['tradeHistoryBump'],
        vaultOwnerBump: decode['vaultOwnerBump']);
  }

  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'instruction'),
        LayoutConst.u8(property: 'tradeHistoryBump'),
        LayoutConst.u8(property: 'vaultOwnerBump'),
      ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexFixedPriceSaleProgramInstruction get instruction =>
      MetaplexFixedPriceSaleProgramInstruction.buy;

  @override
  Map<String, dynamic> serialize() {
    return {
      'tradeHistoryBump': tradeHistoryBump,
      'vaultOwnerBump': vaultOwnerBump
    };
  }
}
