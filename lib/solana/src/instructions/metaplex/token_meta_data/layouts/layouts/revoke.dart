import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/revoke.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataRevokeLayout
    extends MetaplexTokenMetaDataProgramLayout {
  final Revoke revoke;
  const MetaplexTokenMetaDataRevokeLayout({required this.revoke});

  factory MetaplexTokenMetaDataRevokeLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexTokenMetaDataProgramInstruction.revoke.insturction);
    return MetaplexTokenMetaDataRevokeLayout(
        revoke: Revoke.fromValue(decode["discriminator"]));
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u8(property: "discriminator")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction =>
      MetaplexTokenMetaDataProgramInstruction.revoke.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"discriminator": revoke.value};
  }
}
