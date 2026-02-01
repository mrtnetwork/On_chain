import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataBurnV1Layout
    extends MetaplexTokenMetaDataProgramLayout {
  static const int discriminator = 0;
  final BigInt amount;
  const MetaplexTokenMetaDataBurnV1Layout({required this.amount});

  factory MetaplexTokenMetaDataBurnV1Layout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        discriminator: discriminator,
        instruction:
            MetaplexTokenMetaDataProgramInstruction.burnV1.insturction);
    return MetaplexTokenMetaDataBurnV1Layout(amount: decode['amount']);
  }

  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u8(property: 'instruction'),
        LayoutConst.u8(property: 'discriminator'),
        LayoutConst.u64(property: 'amount')
      ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.burnV1;

  @override
  Map<String, dynamic> serialize() {
    return {'discriminator': discriminator, 'amount': amount};
  }
}
