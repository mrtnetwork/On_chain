import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
        tradeHistoryBump: decode["tradeHistoryBump"],
        vaultOwnerBump: decode["vaultOwnerBump"],
        editionMarkerNumber: decode["editionMarkerNumber"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("tradeHistoryBump"),
    LayoutUtils.u8("vaultOwnerBump"),
    LayoutUtils.u64("editionMarkerNumber"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexFixedPriceSaleProgramInstruction.buyV2.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "tradeHistoryBump": tradeHistoryBump,
      "vaultOwnerBump": vaultOwnerBump,
      "editionMarkerNumber": editionMarkerNumber
    };
  }
}
