import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/payload.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/rule_set_toggle.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataUpdateAsProgrammableConfigDelegateV2Layout
    extends MetaplexTokenMetaDataUpdateProgramLayout {
  final RuleSetToggle ruleSet;
  final Payload? authorizationData;
  static int discriminator = 5;
  const MetaplexTokenMetaDataUpdateAsProgrammableConfigDelegateV2Layout(
      {required this.ruleSet, this.authorizationData});

  factory MetaplexTokenMetaDataUpdateAsProgrammableConfigDelegateV2Layout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .updateAsProgrammableConfigDelegateV2.insturction,
        discriminator: discriminator);
    return MetaplexTokenMetaDataUpdateAsProgrammableConfigDelegateV2Layout(
        ruleSet: RuleSetToggle.fromJson(decode['ruleSet']),
        authorizationData: decode['authorizationData'] == null
            ? null
            : Payload.fromJson(decode['authorizationData']));
  }

  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u8(property: 'instruction'),
        LayoutConst.u8(property: 'discriminator'),
        LayoutConst.wrap(RuleSetToggle.staticLayout, property: 'ruleSet'),
        LayoutConst.optional(Payload.staticLayout,
            property: 'authorizationData')
      ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction
          .updateAsProgrammableConfigDelegateV2;

  @override
  Map<String, dynamic> serialize() {
    return {
      'authorizationData': authorizationData?.serialize(),
      'ruleSet': ruleSet.serialize(),
      'discriminator': discriminator
    };
  }
}
