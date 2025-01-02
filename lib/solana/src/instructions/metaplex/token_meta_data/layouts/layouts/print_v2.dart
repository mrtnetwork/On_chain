import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataPrintV2Layout
    extends MetaplexTokenMetaDataProgramLayout {
  final BigInt editionNumber;
  static int discriminator = 1;
  const MetaplexTokenMetaDataPrintV2Layout({required this.editionNumber});

  factory MetaplexTokenMetaDataPrintV2Layout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexTokenMetaDataProgramInstruction.printV2.insturction,
        discriminator: discriminator);
    return MetaplexTokenMetaDataPrintV2Layout(
        editionNumber: decode['editionNumber']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'discriminator'),
    LayoutConst.u64(property: 'editionNumber')
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.printV2;

  @override
  Map<String, dynamic> serialize() {
    return {'discriminator': discriminator, 'editionNumber': editionNumber};
  }
}
