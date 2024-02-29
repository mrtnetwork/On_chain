import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/stake/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class StakeAuthorizeLayout extends StakeProgramLayout {
  final SolAddress newAuthorized;
  final int stakeAuthorizationType;
  const StakeAuthorizeLayout._(this.newAuthorized, this.stakeAuthorizationType);

  factory StakeAuthorizeLayout(
      {required SolAddress newAuthorized,
      required int stakeAuthorizationType}) {
    return StakeAuthorizeLayout._(newAuthorized, stakeAuthorizationType);
  }
  factory StakeAuthorizeLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: StakeProgramInstruction.authorize.insturction);
    return StakeAuthorizeLayout._(
        decode["newAuthorized"], decode["stakeAuthorizationType"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u32("instruction"),
    LayoutUtils.publicKey("newAuthorized"),
    LayoutUtils.u32("stakeAuthorizationType"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => StakeProgramInstruction.authorize.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "newAuthorized": newAuthorized,
      "stakeAuthorizationType": stakeAuthorizationType
    };
  }
}
