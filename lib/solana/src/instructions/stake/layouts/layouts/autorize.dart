import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/stake/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

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

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u32(property: "instruction"),
    SolanaLayoutUtils.publicKey("newAuthorized"),
    LayoutConst.u32(property: "stakeAuthorizationType"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  StakeProgramInstruction get instruction => StakeProgramInstruction.authorize;

  @override
  Map<String, dynamic> serialize() {
    return {
      "newAuthorized": newAuthorized,
      "stakeAuthorizationType": stakeAuthorizationType
    };
  }
}
