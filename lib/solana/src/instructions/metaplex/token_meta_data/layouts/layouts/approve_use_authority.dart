import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
        numberOfUses: decode["numberOfUses"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u64("numberOfUses"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexTokenMetaDataProgramInstruction.approveUseAuthority.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"numberOfUses": numberOfUses};
  }
}
