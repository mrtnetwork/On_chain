import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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

  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), LayoutUtils.u64("edition")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => MetaplexTokenMetaDataProgramInstruction
      .mintNewEditionFromMasterEditionViaVaultProxy.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"edition": edition};
  }
}
