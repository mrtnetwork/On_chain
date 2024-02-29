import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/meta_data_data.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/payload.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataUpdateAsDataItemDelegateV2Layout
    extends MetaplexTokenMetaDataUpdateProgramLayout {
  final MetaDataData? data;
  final Payload? authorizationData;
  static int discriminator = 6;
  const MetaplexTokenMetaDataUpdateAsDataItemDelegateV2Layout(
      {required this.data, this.authorizationData});

  factory MetaplexTokenMetaDataUpdateAsDataItemDelegateV2Layout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .updateAsDataItemDelegateV2.insturction,
        discriminator: discriminator);
    return MetaplexTokenMetaDataUpdateAsDataItemDelegateV2Layout(
        data: MetaDataData.fromJson(decode["metaDataData"]),
        authorizationData: decode["authorizationData"] == null
            ? null
            : Payload.fromJson(decode["authorizationData"]));
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u8("discriminator"),
    LayoutUtils.optional(MetaDataData.staticLayout, property: "metaDataData"),
    LayoutUtils.optional(Payload.staticLayout, property: "authorizationData")
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => MetaplexTokenMetaDataProgramInstruction
      .updateAsDataItemDelegateV2.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": discriminator,
      "metaDataData": data?.serialize(),
      "authorizationData": authorizationData?.serialize()
    };
  }
}
