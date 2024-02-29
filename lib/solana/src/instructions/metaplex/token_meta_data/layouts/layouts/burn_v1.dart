import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataBurnV1Layout
    extends MetaplexTokenMetaDataProgramLayout {
  static final int discriminator = 0;
  final BigInt amount;
  const MetaplexTokenMetaDataBurnV1Layout({required this.amount});

  factory MetaplexTokenMetaDataBurnV1Layout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        discriminator: discriminator,
        instruction:
            MetaplexTokenMetaDataProgramInstruction.burnV1.insturction);
    return MetaplexTokenMetaDataBurnV1Layout(amount: decode["amount"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u8("discriminator"),
    LayoutUtils.u64("amount")
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexTokenMetaDataProgramInstruction.burnV1.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"discriminator": discriminator, "amount": amount};
  }
}
