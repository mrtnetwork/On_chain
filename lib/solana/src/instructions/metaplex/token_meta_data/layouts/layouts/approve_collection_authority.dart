import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataApproveCollectionAuthorityLayout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataApproveCollectionAuthorityLayout();

  factory MetaplexTokenMetaDataApproveCollectionAuthorityLayout.fromBuffer(
      List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .approveCollectionAuthority.insturction);
    return const MetaplexTokenMetaDataApproveCollectionAuthorityLayout();
  }

  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.approveCollectionAuthority;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
