import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexFixedPriceSaleClaimResourceLayout
    extends MetaplexFixedPriceSaleProgramLayout {
  final int vaultOwnerBump;
  MetaplexFixedPriceSaleClaimResourceLayout({required this.vaultOwnerBump});

  factory MetaplexFixedPriceSaleClaimResourceLayout.fromBuffer(List<int> data) {
    final decode = MetaplexFixedPriceSaleProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexFixedPriceSaleProgramInstruction.claimResource.insturction);
    return MetaplexFixedPriceSaleClaimResourceLayout(
        vaultOwnerBump: decode["vaultOwnerBump"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("vaultOwnerBump"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexFixedPriceSaleProgramInstruction.claimResource.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"vaultOwnerBump": vaultOwnerBump};
  }
}
