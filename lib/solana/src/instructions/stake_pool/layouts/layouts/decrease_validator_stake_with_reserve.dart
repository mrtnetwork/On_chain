import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Decrease active stake on a validator layout.
class StakePoolDecreaseValidatorStakeWithReserveLayout
    extends StakePoolProgramLayout {
  /// amount of lamports to split into the transient stake account
  final BigInt lamports;

  /// seed used to create transient stake account
  final BigInt transientStakeSeed;
  StakePoolDecreaseValidatorStakeWithReserveLayout(
      {required this.lamports, required this.transientStakeSeed});

  factory StakePoolDecreaseValidatorStakeWithReserveLayout.fromBuffer(
      List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: StakePoolProgramInstruction
            .decreaseValidatorStakeWithReserve.insturction);
    return StakePoolDecreaseValidatorStakeWithReserveLayout(
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
  int get instruction =>
      StakePoolProgramInstruction.decreaseValidatorStakeWithReserve.insturction;

  @override
  Structure get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {"lamports": lamports, "transientStakeSeed": transientStakeSeed};
  }
}
