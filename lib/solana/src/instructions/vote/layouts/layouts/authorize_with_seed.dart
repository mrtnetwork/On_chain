import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/vote/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

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
        Map<String, dynamic>.from(decode['voteAuthorizeWithSeedArgs']);
    return VoteProgramAuthorizeWithSeedLayout(
        newAuthorized: voteData['newAuthorized'],
        currentAuthorityDerivedKeyOwnerPubkey:
            voteData['currentAuthorityDerivedKeyOwnerPubkey'],
        currentAuthorityDerivedKeySeed:
            voteData['currentAuthorityDerivedKeySeed'],
        voteAuthorizationType: voteData['voteAuthorizationType']);
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
  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u32(property: 'instruction'),
        LayoutConst.struct([
          LayoutConst.u32(property: 'voteAuthorizationType'),
          SolanaLayoutUtils.publicKey('currentAuthorityDerivedKeyOwnerPubkey'),
          LayoutConst.rustString(property: 'currentAuthorityDerivedKeySeed'),
          SolanaLayoutUtils.publicKey('newAuthorized')
        ], property: 'voteAuthorizeWithSeedArgs'),
      ]);

  @override
  StructLayout get layout => _layout;

  @override
  VoteProgramInstruction get instruction =>
      VoteProgramInstruction.authorizeWithSeed;

  @override
  Map<String, dynamic> serialize() {
    return {
      'voteAuthorizeWithSeedArgs': {
        'voteAuthorizationType': voteAuthorizationType,
        'currentAuthorityDerivedKeyOwnerPubkey':
            currentAuthorityDerivedKeyOwnerPubkey,
        'currentAuthorityDerivedKeySeed': currentAuthorityDerivedKeySeed,
        'newAuthorized': newAuthorized
      }
    };
  }
}
