import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/meta_data_data.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/payload.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u8(property: "discriminator"),
    LayoutConst.optional(MetaDataData.staticLayout, property: "metaDataData"),
    LayoutConst.optional(Payload.staticLayout, property: "authorizationData")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.updateAsDataItemDelegateV2;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": discriminator,
      "metaDataData": data?.serialize(),
      "authorizationData": authorizationData?.serialize()
    };
  }
}
