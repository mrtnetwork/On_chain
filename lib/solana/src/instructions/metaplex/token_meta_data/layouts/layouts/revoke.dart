import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/revoke.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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

  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), LayoutUtils.u8("discriminator")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexTokenMetaDataProgramInstruction.revoke.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"discriminator": revoke.value};
  }
}
