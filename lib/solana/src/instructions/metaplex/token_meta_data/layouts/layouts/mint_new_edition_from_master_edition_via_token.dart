import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataMintNewEditionFromMasterEditionViaTokenLayout
    extends MetaplexTokenMetaDataProgramLayout {
  final BigInt edition;
  const MetaplexTokenMetaDataMintNewEditionFromMasterEditionViaTokenLayout(
      {required this.edition});

  factory MetaplexTokenMetaDataMintNewEditionFromMasterEditionViaTokenLayout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .mintNewEditionFromMasterEditionViaToken.insturction);
    return MetaplexTokenMetaDataMintNewEditionFromMasterEditionViaTokenLayout(
        edition: decode["edition"]);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u64(property: "edition")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction => MetaplexTokenMetaDataProgramInstruction
      .mintNewEditionFromMasterEditionViaToken.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"edition": edition};
  }
}
