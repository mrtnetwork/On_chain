import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/collection_toggle.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/payload.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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
        collection: CollectionToggle.fromJson(decode['collection']),
        authorizationData: decode['authorizationData'] == null
            ? null
            : Payload.fromJson(decode['authorizationData']));
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'discriminator'),
    LayoutConst.wrap(CollectionToggle.staticLayout, property: 'collection'),
    LayoutConst.optional(Payload.staticLayout, property: 'authorizationData')
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.updateAsCollectionDelegateV2;

  @override
  Map<String, dynamic> serialize() {
    return {
      'authorizationData': authorizationData?.serialize(),
      'discriminator': discriminator,
      'collection': collection.serialize()
    };
  }
}
