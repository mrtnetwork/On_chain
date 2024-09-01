import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Increase stake on a validator from the reserve account layout.
class StakePoolIncreaseValidatorStakeLayout extends StakePoolProgramLayout {
  /// amount of lamports to increase on the given validator
  final BigInt lamports;

  /// seed used to create transient stake account
  final BigInt transientStakeSeed;
  StakePoolIncreaseValidatorStakeLayout(
      {required this.lamports, required this.transientStakeSeed});

  factory StakePoolIncreaseValidatorStakeLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction:
            StakePoolProgramInstruction.increaseValidatorStake.insturction);
    return StakePoolIncreaseValidatorStakeLayout(
      lamports: decode["lamports"],
      transientStakeSeed: decode["transientStakeSeed"],
    );
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.ns64(property: "lamports"),
    LayoutConst.ns64(property: "transientStakeSeed")
  ]);
  @override
  StructLayout get layout => _layout;

  @override
  StakePoolProgramInstruction get instruction =>
      StakePoolProgramInstruction.increaseValidatorStake;
  @override
  Map<String, dynamic> serialize() {
    return {"lamports": lamports, "transientStakeSeed": transientStakeSeed};
  }
}
