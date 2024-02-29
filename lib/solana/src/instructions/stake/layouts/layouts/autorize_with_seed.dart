import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/stake/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
        newAuthorized: decode["newAuthorized"],
        stakeAuthorizationType: decode["stakeAuthorizationType"],
        authoritySeed: decode["authoritySeed"],
        authorityOwner: decode["authorityOwner"]);
  }
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u32("instruction"),
    LayoutUtils.publicKey("newAuthorized"),
    LayoutUtils.u32("stakeAuthorizationType"),
    LayoutUtils.rustString("authoritySeed"),
    LayoutUtils.publicKey("authorityOwner")
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => StakeProgramInstruction.authorizeWithSeed.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "newAuthorized": newAuthorized,
      "stakeAuthorizationType": stakeAuthorizationType,
      "authoritySeed": authoritySeed,
      "authorityOwner": authorityOwner
    };
  }
}
