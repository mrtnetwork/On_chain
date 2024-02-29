import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.ns64("lamports"),
    LayoutUtils.ns64("transientStakeSeed")
  ]);
  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      StakePoolProgramInstruction.increaseValidatorStake.insturction;
  @override
  Map<String, dynamic> serialize() {
    return {"lamports": lamports, "transientStakeSeed": transientStakeSeed};
  }
}
