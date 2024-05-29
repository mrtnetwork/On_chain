import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataMintNewEditionFromMasterEditionViaVaultProxyLayout
    extends MetaplexTokenMetaDataProgramLayout {
  final BigInt edition;
  const MetaplexTokenMetaDataMintNewEditionFromMasterEditionViaVaultProxyLayout(
      {required this.edition});

  factory MetaplexTokenMetaDataMintNewEditionFromMasterEditionViaVaultProxyLayout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .mintNewEditionFromMasterEditionViaVaultProxy.insturction);
    return MetaplexTokenMetaDataMintNewEditionFromMasterEditionViaVaultProxyLayout(
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
      .mintNewEditionFromMasterEditionViaVaultProxy.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"edition": edition};
  }
}
