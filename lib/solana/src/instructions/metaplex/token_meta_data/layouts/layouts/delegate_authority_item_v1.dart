import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/payload.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataDelegateAuthorityItemV1Layout
    extends MetaplexTokenMetaDataDelegateProgramLayout {
  final Payload? authorizationData;
  const MetaplexTokenMetaDataDelegateAuthorityItemV1Layout(
      {this.authorizationData});

  factory MetaplexTokenMetaDataDelegateAuthorityItemV1Layout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .delegateAuthorityItemV1.insturction,
        discriminator: discriminator);
    return MetaplexTokenMetaDataDelegateAuthorityItemV1Layout(
        authorizationData: decode['authorizationData'] == null
            ? null
            : Payload.fromJson(decode['authorizationData']));
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'discriminator'),
    LayoutConst.optional(Payload.staticLayout, property: 'authorizationData'),
  ]);
  static const int discriminator = 9;
  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.delegateAuthorityItemV1;

  @override
  Map<String, dynamic> serialize() {
    return {
      'authorizationData': authorizationData?.serialize(),
      'discriminator': discriminator
    };
  }
}
