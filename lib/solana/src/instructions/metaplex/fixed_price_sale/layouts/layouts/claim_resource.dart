import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

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
        vaultOwnerBump: decode['vaultOwnerBump']);
  }

  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'instruction'),
        LayoutConst.u8(property: 'vaultOwnerBump'),
      ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexFixedPriceSaleProgramInstruction get instruction =>
      MetaplexFixedPriceSaleProgramInstruction.claimResource;

  @override
  Map<String, dynamic> serialize() {
    return {'vaultOwnerBump': vaultOwnerBump};
  }
}
