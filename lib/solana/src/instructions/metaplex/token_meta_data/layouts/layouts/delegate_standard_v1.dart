import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataDelegateStandardV1Layout
    extends MetaplexTokenMetaDataDelegateProgramLayout {
  final BigInt amount;
  static const int discriminator = 6;
  const MetaplexTokenMetaDataDelegateStandardV1Layout({required this.amount});

  factory MetaplexTokenMetaDataDelegateStandardV1Layout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .delegateStandardV1.insturction,
        discriminator: discriminator);
    return MetaplexTokenMetaDataDelegateStandardV1Layout(
        amount: decode["amount"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u8("discriminator"),
    LayoutUtils.u64("amount"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexTokenMetaDataProgramInstruction.delegateStandardV1.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"discriminator": discriminator, "amount": amount};
  }
}
