import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/stake/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class StakeAuthorizeWithSeedLayout extends StakeProgramLayout {
  final SolAddress newAuthorized;
  final int stakeAuthorizationType;
  final String authoritySeed;
  final SolAddress authorityOwner;
  const StakeAuthorizeWithSeedLayout._({
    required this.newAuthorized,
    required this.stakeAuthorizationType,
    required this.authorityOwner,
    required this.authoritySeed,
  });

  factory StakeAuthorizeWithSeedLayout(
      {required SolAddress newAuthorized,
      required int stakeAuthorizationType,
      required String authoritySeed,
      required SolAddress authorityOwner}) {
    return StakeAuthorizeWithSeedLayout._(
        newAuthorized: newAuthorized,
        stakeAuthorizationType: stakeAuthorizationType,
        authorityOwner: authorityOwner,
        authoritySeed: authoritySeed);
  }
  factory StakeAuthorizeWithSeedLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: StakeProgramInstruction.authorizeWithSeed.insturction);
    return StakeAuthorizeWithSeedLayout(
        newAuthorized: decode['newAuthorized'],
        stakeAuthorizationType: decode['stakeAuthorizationType'],
        authoritySeed: decode['authoritySeed'],
        authorityOwner: decode['authorityOwner']);
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u32(property: 'instruction'),
    SolanaLayoutUtils.publicKey('newAuthorized'),
    LayoutConst.u32(property: 'stakeAuthorizationType'),
    LayoutConst.rustString(property: 'authoritySeed'),
    SolanaLayoutUtils.publicKey('authorityOwner')
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  StakeProgramInstruction get instruction =>
      StakeProgramInstruction.authorizeWithSeed;

  @override
  Map<String, dynamic> serialize() {
    return {
      'newAuthorized': newAuthorized,
      'stakeAuthorizationType': stakeAuthorizationType,
      'authoritySeed': authoritySeed,
      'authorityOwner': authorityOwner
    };
  }
}
