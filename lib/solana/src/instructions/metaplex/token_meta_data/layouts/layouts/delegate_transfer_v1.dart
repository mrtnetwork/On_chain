import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/payload.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataDelegateTransferV1Layout
    extends MetaplexTokenMetaDataDelegateProgramLayout {
  final Payload? authorizationData;
  final BigInt amount;
  static const int discriminator = 2;
  const MetaplexTokenMetaDataDelegateTransferV1Layout(
      {this.authorizationData, required this.amount});

  factory MetaplexTokenMetaDataDelegateTransferV1Layout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .delegateTransferV1.insturction,
        discriminator: discriminator);
    return MetaplexTokenMetaDataDelegateTransferV1Layout(
        authorizationData: decode['authorizationData'] == null
            ? null
            : Payload.fromJson(decode['authorizationData']),
        amount: decode['amount']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'discriminator'),
    LayoutConst.u64(property: 'amount'),
    LayoutConst.optional(Payload.staticLayout, property: 'authorizationData'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.delegateTransferV1;

  @override
  Map<String, dynamic> serialize() {
    return {
      'authorizationData': authorizationData?.serialize(),
      'discriminator': discriminator,
      'amount': amount
    };
  }
}
