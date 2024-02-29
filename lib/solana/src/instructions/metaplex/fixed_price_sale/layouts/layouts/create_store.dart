import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
        name: decode["name"], description: decode["description"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.string("name"),
    LayoutUtils.string("description"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexFixedPriceSaleProgramInstruction.createStore.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"name": name, "description": description};
  }
}
