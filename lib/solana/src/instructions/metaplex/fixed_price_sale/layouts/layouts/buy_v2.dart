import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexFixedPriceSaleBuyV2Layout
    extends MetaplexFixedPriceSaleProgramLayout {
  final int tradeHistoryBump;
  final int vaultOwnerBump;
  final BigInt editionMarkerNumber;

  const MetaplexFixedPriceSaleBuyV2Layout(
      {required this.tradeHistoryBump,
      required this.vaultOwnerBump,
      required this.editionMarkerNumber});

  factory MetaplexFixedPriceSaleBuyV2Layout.fromBuffer(List<int> data) {
    final decode = MetaplexFixedPriceSaleProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexFixedPriceSaleProgramInstruction.buyV2.insturction);
    return MetaplexFixedPriceSaleBuyV2Layout(
        tradeHistoryBump: decode['tradeHistoryBump'],
        vaultOwnerBump: decode['vaultOwnerBump'],
        editionMarkerNumber: decode['editionMarkerNumber']);
  }

  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'instruction'),
        LayoutConst.u8(property: 'tradeHistoryBump'),
        LayoutConst.u8(property: 'vaultOwnerBump'),
        LayoutConst.u64(property: 'editionMarkerNumber'),
      ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexFixedPriceSaleProgramInstruction get instruction =>
      MetaplexFixedPriceSaleProgramInstruction.buyV2;

  @override
  Map<String, dynamic> serialize() {
    return {
      'tradeHistoryBump': tradeHistoryBump,
      'vaultOwnerBump': vaultOwnerBump,
      'editionMarkerNumber': editionMarkerNumber
    };
  }
}
