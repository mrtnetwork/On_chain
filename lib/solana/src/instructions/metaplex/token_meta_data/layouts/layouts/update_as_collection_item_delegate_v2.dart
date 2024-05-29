import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/collection_toggle.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/payload.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataUpdateAsCollectionItemDelegateV2Layout
    extends MetaplexTokenMetaDataUpdateProgramLayout {
  final Payload? authorizationData;
  final CollectionToggle collection;
  static int discriminator = 7;
  const MetaplexTokenMetaDataUpdateAsCollectionItemDelegateV2Layout(
      {required this.collection, this.authorizationData});

  factory MetaplexTokenMetaDataUpdateAsCollectionItemDelegateV2Layout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .updateAsCollectionItemDelegateV2.insturction);
    return MetaplexTokenMetaDataUpdateAsCollectionItemDelegateV2Layout(
        collection: CollectionToggle.fromJson(decode["collection"]),
        authorizationData: decode["authorizationData"] == null
            ? null
            : Payload.fromJson(decode["authorizationData"]));
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u8(property: "discriminator"),
    LayoutConst.wrap(CollectionToggle.staticLayout, property: "collection"),
    LayoutConst.optional(Payload.staticLayout, property: "authorizationData")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction => MetaplexTokenMetaDataProgramInstruction
      .updateAsCollectionItemDelegateV2.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "authorizationData": authorizationData?.serialize(),
      "discriminator": discriminator,
      "collection": collection.serialize()
    };
  }
}
