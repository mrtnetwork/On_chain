import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/payload.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/rule_set_toggle.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u8("discriminator"),
    LayoutUtils.wrap(RuleSetToggle.staticLayout, property: "ruleSet"),
    LayoutUtils.optional(Payload.staticLayout, property: "authorizationData")
  ]);

  @override
  Structure get layout => _layout;

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
