import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Increase stake on a validator again in an epoch layout.
class StakePoolIncreaseAdditionalValidatorStakeLayout
    extends StakePoolProgramLayout {
  /// amount of lamports to increase on the given validator
  final BigInt lamports;

  /// seed used to create transient stake account
  final BigInt transientStakeSeed;

  /// seed used to create ephemeral account.
  final BigInt ephemeralStakeSeed;
  const StakePoolIncreaseAdditionalValidatorStakeLayout(
      {required this.lamports,
      required this.ephemeralStakeSeed,
      required this.transientStakeSeed});

  factory StakePoolIncreaseAdditionalValidatorStakeLayout.fromBuffer(
      List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: StakePoolProgramInstruction
            .increaseAdditionalValidatorStake.insturction);
    return StakePoolIncreaseAdditionalValidatorStakeLayout(
      ephemeralStakeSeed: decode["ephemeralStakeSeed"],
      lamports: decode["lamports"],
      transientStakeSeed: decode["transientStakeSeed"],
    );
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.ns64("lamports"),
    LayoutUtils.ns64("transientStakeSeed"),
    LayoutUtils.ns64("ephemeralStakeSeed")
  ]);

  @override
  Structure get layout => _layout;
  @override
  int get instruction =>
      StakePoolProgramInstruction.increaseAdditionalValidatorStake.insturction;
  @override
  Map<String, dynamic> serialize() {
    return {
      "lamports": lamports,
      "ephemeralStakeSeed": ephemeralStakeSeed,
      "transientStakeSeed": transientStakeSeed
    };
  }
}
