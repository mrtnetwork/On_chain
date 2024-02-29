import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Decrease active stake again from a validator layout.
class StakePoolDecreaseAdditionalValidatorStakeLayout
    extends StakePoolProgramLayout {
  /// amount of lamports to split into the transient stake account
  final BigInt lamports;

  /// seed used to create transient stake account
  final BigInt transientStakeSeed;

  /// seed used to create ephemeral account.
  final BigInt ephemeralStakeSeed;
  const StakePoolDecreaseAdditionalValidatorStakeLayout(
      {required this.lamports,
      required this.ephemeralStakeSeed,
      required this.transientStakeSeed});

  factory StakePoolDecreaseAdditionalValidatorStakeLayout.fromBuffer(
      List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: StakePoolProgramInstruction
            .decreaseAdditionalValidatorStake.insturction);
    return StakePoolDecreaseAdditionalValidatorStakeLayout(
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
  int get instruction =>
      StakePoolProgramInstruction.decreaseAdditionalValidatorStake.insturction;

  @override
  Structure get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "lamports": lamports,
      "ephemeralStakeSeed": ephemeralStakeSeed,
      "transientStakeSeed": transientStakeSeed
    };
  }
}
