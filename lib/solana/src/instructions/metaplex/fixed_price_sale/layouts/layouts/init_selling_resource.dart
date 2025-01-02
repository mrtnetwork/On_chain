import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

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
        masterEditionBump: decode['masterEditionBump'],
        vaultOwnerBump: decode['vaultOwnerBump'],
        maxSupply: decode['maxSupply']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.u8(property: 'masterEditionBump'),
    LayoutConst.u8(property: 'vaultOwnerBump'),
    LayoutConst.optional(LayoutConst.u64(), property: 'maxSupply'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexFixedPriceSaleProgramInstruction get instruction =>
      MetaplexFixedPriceSaleProgramInstruction.initSellingResource;

  @override
  Map<String, dynamic> serialize() {
    return {
      'masterEditionBump': masterEditionBump,
      'vaultOwnerBump': vaultOwnerBump,
      'maxSupply': maxSupply
    };
  }
}
