import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataapproveUseAuthorityLayout
    extends MetaplexTokenMetaDataProgramLayout {
  final BigInt numberOfUses;
  const MetaplexTokenMetaDataapproveUseAuthorityLayout(
      {required this.numberOfUses});

  factory MetaplexTokenMetaDataapproveUseAuthorityLayout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .approveUseAuthority.insturction);
    return MetaplexTokenMetaDataapproveUseAuthorityLayout(
        numberOfUses: decode['numberOfUses']);
  }

  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u8(property: 'instruction'),
        LayoutConst.u64(property: 'numberOfUses'),
      ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.approveUseAuthority;

  @override
  Map<String, dynamic> serialize() {
    return {'numberOfUses': numberOfUses};
  }
}
