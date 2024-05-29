import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/payload.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/rule_set_toggle.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataUpdateAsProgrammableConfigItemDelegateV2Layout
    extends MetaplexTokenMetaDataUpdateProgramLayout {
  final RuleSetToggle ruleSet;
  static int discriminator = 8;
  final Payload? authorizationData;
  const MetaplexTokenMetaDataUpdateAsProgrammableConfigItemDelegateV2Layout(
      {required this.ruleSet, this.authorizationData});

  factory MetaplexTokenMetaDataUpdateAsProgrammableConfigItemDelegateV2Layout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .updateAsProgrammableConfigItemDelegateV2.insturction,
        discriminator: discriminator);
    return MetaplexTokenMetaDataUpdateAsProgrammableConfigItemDelegateV2Layout(
        ruleSet: RuleSetToggle.fromJson(decode["ruleSet"]),
        authorizationData: decode["authorizationData"] == null
            ? null
            : Payload.fromJson(decode["authorizationData"]));
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u8(property: "discriminator"),
    LayoutConst.wrap(RuleSetToggle.staticLayout, property: "ruleSet"),
    LayoutConst.optional(Payload.staticLayout, property: "authorizationData")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction => MetaplexTokenMetaDataProgramInstruction
      .updateAsProgrammableConfigItemDelegateV2.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "authorizationData": authorizationData?.serialize(),
      "ruleSet": ruleSet.serialize(),
      "discriminator": discriminator
    };
  }
}
