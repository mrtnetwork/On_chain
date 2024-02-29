import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/types/types/creator.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexFixedPriceSaleSavePrimaryMetadataCreatorsLayout
    extends MetaplexFixedPriceSaleProgramLayout {
  MetaplexFixedPriceSaleSavePrimaryMetadataCreatorsLayout(
      {required this.primaryMetadataCreatorsBump, required this.creators});

  /// Constructs the layout from raw bytes.
  factory MetaplexFixedPriceSaleSavePrimaryMetadataCreatorsLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexFixedPriceSaleProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexFixedPriceSaleProgramInstruction
            .savePrimaryMetadataCreators.insturction);
    return MetaplexFixedPriceSaleSavePrimaryMetadataCreatorsLayout(
        primaryMetadataCreatorsBump: decode["primaryMetadataCreatorsBump"],
        creators: (decode["creators"] as List)
            .map((e) => Creator.fromJson(e))
            .toList());
  }
  final int primaryMetadataCreatorsBump;
  final List<Creator> creators;

  /// Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("primaryMetadataCreatorsBump"),
    LayoutUtils.vec(Creator.creatorLayout, property: "creators")
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction => MetaplexFixedPriceSaleProgramInstruction
      .savePrimaryMetadataCreators.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "primaryMetadataCreatorsBump": primaryMetadataCreatorsBump,
      "creators": creators.map((e) => e.serialize()).toList()
    };
  }
}
