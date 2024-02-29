import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataPrintV1Layout
    extends MetaplexTokenMetaDataProgramLayout {
  final BigInt editionNumber;
  static int discriminator = 0;
  const MetaplexTokenMetaDataPrintV1Layout({required this.editionNumber});

  factory MetaplexTokenMetaDataPrintV1Layout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexTokenMetaDataProgramInstruction.printV1.insturction,
        discriminator: discriminator);
    return MetaplexTokenMetaDataPrintV1Layout(
        editionNumber: decode["editionNumber"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u8("discriminator"),
    LayoutUtils.u64("editionNumber")
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexTokenMetaDataProgramInstruction.printV1.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"discriminator": discriminator, "editionNumber": editionNumber};
  }
}
