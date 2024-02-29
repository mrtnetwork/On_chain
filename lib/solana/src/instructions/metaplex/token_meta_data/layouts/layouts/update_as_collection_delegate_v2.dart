import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/collection_toggle.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/payload.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataUpdateAsCollectionDelegateV2Layout
    extends MetaplexTokenMetaDataUpdateProgramLayout {
  final Payload? authorizationData;
  final CollectionToggle collection;
  static int discriminator = 3;
  const MetaplexTokenMetaDataUpdateAsCollectionDelegateV2Layout(
      {required this.collection, this.authorizationData});

  factory MetaplexTokenMetaDataUpdateAsCollectionDelegateV2Layout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .updateAsCollectionDelegateV2.insturction);
    return MetaplexTokenMetaDataUpdateAsCollectionDelegateV2Layout(
        collection: CollectionToggle.fromJson(decode["collection"]),
        authorizationData: decode["authorizationData"] == null
            ? null
            : Payload.fromJson(decode["authorizationData"]));
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u8("discriminator"),
    LayoutUtils.wrap(CollectionToggle.staticLayout, property: "collection"),
    LayoutUtils.optional(Payload.staticLayout, property: "authorizationData")
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => MetaplexTokenMetaDataProgramInstruction
      .updateAsCollectionDelegateV2.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "authorizationData": authorizationData?.serialize(),
      "discriminator": discriminator,
      "collection": collection.serialize()
    };
  }
}
