import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/vote/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// AuthorizeWithSeed layout
class VoteProgramAuthorizeWithSeedLayout extends VoteProgramLayout {
  final SolAddress newAuthorized;
  final SolAddress currentAuthorityDerivedKeyOwnerPubkey;
  final String currentAuthorityDerivedKeySeed;
  final int voteAuthorizationType;
  const VoteProgramAuthorizeWithSeedLayout._(
      {required this.newAuthorized,
      required this.currentAuthorityDerivedKeyOwnerPubkey,
      required this.currentAuthorityDerivedKeySeed,
      required this.voteAuthorizationType});
  factory VoteProgramAuthorizeWithSeedLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: VoteProgramInstruction.authorizeWithSeed.insturction);
    final voteData =
        Map<String, dynamic>.from(decode["voteAuthorizeWithSeedArgs"]);
    return VoteProgramAuthorizeWithSeedLayout(
        newAuthorized: voteData["newAuthorized"],
        currentAuthorityDerivedKeyOwnerPubkey:
            voteData["currentAuthorityDerivedKeyOwnerPubkey"],
        currentAuthorityDerivedKeySeed:
            voteData["currentAuthorityDerivedKeySeed"],
        voteAuthorizationType: voteData["voteAuthorizationType"]);
  }
  factory VoteProgramAuthorizeWithSeedLayout(
      {required SolAddress newAuthorized,
      required SolAddress currentAuthorityDerivedKeyOwnerPubkey,
      required String currentAuthorityDerivedKeySeed,
      required int voteAuthorizationType}) {
    return VoteProgramAuthorizeWithSeedLayout._(
        newAuthorized: newAuthorized,
        currentAuthorityDerivedKeyOwnerPubkey:
            currentAuthorityDerivedKeyOwnerPubkey,
        currentAuthorityDerivedKeySeed: currentAuthorityDerivedKeySeed,
        voteAuthorizationType: voteAuthorizationType);
  }
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u32("instruction"),
    LayoutUtils.struct([
      LayoutUtils.u32("voteAuthorizationType"),
      LayoutUtils.publicKey("currentAuthorityDerivedKeyOwnerPubkey"),
      LayoutUtils.rustString("currentAuthorityDerivedKeySeed"),
      LayoutUtils.publicKey("newAuthorized")
    ], "voteAuthorizeWithSeedArgs"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => VoteProgramInstruction.authorizeWithSeed.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "voteAuthorizeWithSeedArgs": {
        "voteAuthorizationType": voteAuthorizationType,
        "currentAuthorityDerivedKeyOwnerPubkey":
            currentAuthorityDerivedKeyOwnerPubkey,
        "currentAuthorityDerivedKeySeed": currentAuthorityDerivedKeySeed,
        "newAuthorized": newAuthorized
      }
    };
  }
}
