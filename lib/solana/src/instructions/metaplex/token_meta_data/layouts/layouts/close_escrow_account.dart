import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataCloseEscrowAccountLayout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataCloseEscrowAccountLayout();

  factory MetaplexTokenMetaDataCloseEscrowAccountLayout.fromBuffer(
      List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .closeEscrowAccount.insturction);
    return const MetaplexTokenMetaDataCloseEscrowAccountLayout();
  }

  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.closeEscrowAccount;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
