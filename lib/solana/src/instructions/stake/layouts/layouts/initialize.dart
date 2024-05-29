import 'package:on_chain/solana/src/instructions/stake/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/stake/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class StakeInitializeLayout extends StakeProgramLayout {
  /// Authorities of the new stake account
  final StakeAuthorized authorized;

  /// Lockup of the new stake account
  final StakeLockup lockup;

  const StakeInitializeLayout._(this.authorized, this.lockup);
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u32(property: "instruction"),
    StakeAuthorized.staticLayout,
    StakeLockup.staticLayout,
  ]);

  factory StakeInitializeLayout(
      {required StakeAuthorized authorized, StakeLockup? lockup}) {
    return StakeInitializeLayout._(
        authorized, lockup ?? StakeLockup.defaultLockup);
  }
  factory StakeInitializeLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: StakeProgramInstruction.initialize.insturction);
    return StakeInitializeLayout(
        authorized: StakeAuthorized.fromJson(decode["authorized"]),
        lockup: StakeLockup.fromJson(decode["lockup"]));
  }

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction => StakeProgramInstruction.initialize.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"authorized": authorized.serialize(), "lockup": lockup.serialize()};
  }
}
