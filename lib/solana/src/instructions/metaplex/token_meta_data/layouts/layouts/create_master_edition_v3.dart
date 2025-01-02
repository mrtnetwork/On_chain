import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataCreateMasterEditionV3Layout
    extends MetaplexTokenMetaDataProgramLayout {
  final BigInt? maxSupply;
  const MetaplexTokenMetaDataCreateMasterEditionV3Layout({this.maxSupply});

  factory MetaplexTokenMetaDataCreateMasterEditionV3Layout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .createMasterEditionV3.insturction);
    return MetaplexTokenMetaDataCreateMasterEditionV3Layout(
        maxSupply: decode['maxSupply']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.optional(LayoutConst.u64(), property: 'maxSupply')
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.createMasterEditionV3;

  @override
  Map<String, dynamic> serialize() {
    return {'maxSupply': maxSupply};
  }
}
