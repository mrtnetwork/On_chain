import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataConvertMasterEditionV1ToV2Layout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataConvertMasterEditionV1ToV2Layout();

  factory MetaplexTokenMetaDataConvertMasterEditionV1ToV2Layout.fromBuffer(
      List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .convertMasterEditionV1ToV2.insturction);
    return const MetaplexTokenMetaDataConvertMasterEditionV1ToV2Layout();
  }

  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.convertMasterEditionV1ToV2;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
