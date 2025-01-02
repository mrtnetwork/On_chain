import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexFixedPriceSaleCreateStoreLayout
    extends MetaplexFixedPriceSaleProgramLayout {
  final String name;
  final String description;
  MetaplexFixedPriceSaleCreateStoreLayout(
      {required this.name, required this.description});

  factory MetaplexFixedPriceSaleCreateStoreLayout.fromBuffer(List<int> data) {
    final decode = MetaplexFixedPriceSaleProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexFixedPriceSaleProgramInstruction.createStore.insturction);
    return MetaplexFixedPriceSaleCreateStoreLayout(
        name: decode['name'], description: decode['description']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.string(property: 'name'),
    LayoutConst.string(property: 'description'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexFixedPriceSaleProgramInstruction get instruction =>
      MetaplexFixedPriceSaleProgramInstruction.createStore;

  @override
  Map<String, dynamic> serialize() {
    return {'name': name, 'description': description};
  }
}
