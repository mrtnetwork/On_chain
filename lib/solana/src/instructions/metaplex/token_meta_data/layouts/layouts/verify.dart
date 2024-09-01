import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/verification.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataVerifyCollectionV1Layout
    extends MetaplexTokenMetaDataProgramLayout {
  final Verification verification;
  const MetaplexTokenMetaDataVerifyCollectionV1Layout(
      {required this.verification});

  factory MetaplexTokenMetaDataVerifyCollectionV1Layout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .verifyCollectionV1.insturction);
    return MetaplexTokenMetaDataVerifyCollectionV1Layout(
        verification: Verification.fromValue(decode["discriminator"]));
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u8(property: "discriminator")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.verifyCollectionV1;

  @override
  Map<String, dynamic> serialize() {
    return {"discriminator": verification.value};
  }
}
