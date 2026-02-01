import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataRemoveCreatorVerificationLayout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataRemoveCreatorVerificationLayout();

  factory MetaplexTokenMetaDataRemoveCreatorVerificationLayout.fromBuffer(
      List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .removeCreatorVerification.insturction);
    return const MetaplexTokenMetaDataRemoveCreatorVerificationLayout();
  }

  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.removeCreatorVerification;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
