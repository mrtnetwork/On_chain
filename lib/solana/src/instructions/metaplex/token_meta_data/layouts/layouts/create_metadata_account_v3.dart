import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/collection_details.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/meta_data_v2.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

///
class MetaplexTokenMetaDataCreateMetadataAccountV3Layout
    extends MetaplexTokenMetaDataProgramLayout {
  final MetaDataV2 metaDataV2;
  final bool isMutable;
  final CollectionDetailsV1? collectionDetailsV1;
  const MetaplexTokenMetaDataCreateMetadataAccountV3Layout(
      {required this.metaDataV2,
      required this.isMutable,
      this.collectionDetailsV1});

  factory MetaplexTokenMetaDataCreateMetadataAccountV3Layout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .createMetadataAccountV3.insturction);
    return MetaplexTokenMetaDataCreateMetadataAccountV3Layout(
        metaDataV2: MetaDataV2.fromJson(decode["metaDataV2"]),
        isMutable: decode["isMutable"],
        collectionDetailsV1: decode["collectionDetails"] == null
            ? null
            : CollectionDetailsV1.fromJson(decode["collectionDetails"]));
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    MetaDataV2.staticLayout,
    LayoutUtils.boolean(property: "isMutable"),
    LayoutUtils.optional(CollectionDetailsV1.staticLayout,
        property: "collectionDetails"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => MetaplexTokenMetaDataProgramInstruction
      .createMetadataAccountV3.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "metaDataV2": metaDataV2.serialize(),
      "isMutable": isMutable,
      "collectionDetails": collectionDetailsV1?.serialize()
    };
  }
}
