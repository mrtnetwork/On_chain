import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexFixedPriceSaleInitSellingResourceLayout
    extends MetaplexFixedPriceSaleProgramLayout {
  final int masterEditionBump;
  final int vaultOwnerBump;
  final BigInt? maxSupply;
  MetaplexFixedPriceSaleInitSellingResourceLayout(
      {required this.masterEditionBump,
      required this.vaultOwnerBump,
      this.maxSupply});

  factory MetaplexFixedPriceSaleInitSellingResourceLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexFixedPriceSaleProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexFixedPriceSaleProgramInstruction
            .initSellingResource.insturction);
    return MetaplexFixedPriceSaleInitSellingResourceLayout(
        masterEditionBump: decode["masterEditionBump"],
        vaultOwnerBump: decode["vaultOwnerBump"],
        maxSupply: decode["maxSupply"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("masterEditionBump"),
    LayoutUtils.u8("vaultOwnerBump"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "maxSupply"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexFixedPriceSaleProgramInstruction.initSellingResource.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "masterEditionBump": masterEditionBump,
      "vaultOwnerBump": vaultOwnerBump,
      "maxSupply": maxSupply
    };
  }
}
