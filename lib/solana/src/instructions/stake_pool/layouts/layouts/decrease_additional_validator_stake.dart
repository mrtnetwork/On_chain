import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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
      ephemeralStakeSeed: decode['ephemeralStakeSeed'],
      lamports: decode['lamports'],
      transientStakeSeed: decode['transientStakeSeed'],
    );
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.ns64(property: 'lamports'),
    LayoutConst.ns64(property: 'transientStakeSeed'),
    LayoutConst.ns64(property: 'ephemeralStakeSeed')
  ]);

  @override
  StakePoolProgramInstruction get instruction =>
      StakePoolProgramInstruction.decreaseAdditionalValidatorStake;

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'lamports': lamports,
      'ephemeralStakeSeed': ephemeralStakeSeed,
      'transientStakeSeed': transientStakeSeed
    };
  }
}
