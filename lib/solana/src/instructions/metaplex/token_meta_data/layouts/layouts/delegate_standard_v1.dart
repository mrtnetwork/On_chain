import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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
        amount: decode['amount']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'discriminator'),
    LayoutConst.u64(property: 'amount'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.delegateStandardV1;

  @override
  Map<String, dynamic> serialize() {
    return {'discriminator': discriminator, 'amount': amount};
  }
}
