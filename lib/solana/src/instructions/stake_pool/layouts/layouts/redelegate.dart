import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Redelegate active stake on a validator layout.
class StakePoolReDelegateLayout extends StakePoolProgramLayout {
  /// Amount of lamports to redelegate
  final BigInt lamports;

  /// Seed used to create source transient stake account
  final BigInt sourceTransientStakeSeed;

  /// Seed used to create destination ephemeral account.
  final BigInt ephemeralStakeSeed;

  /// Seed used to create destination transient stake account. If there is
  /// already transient stake, this must match the current seed, otherwise
  /// it can be anything
  final BigInt destinationTransientStakeSeed;
  StakePoolReDelegateLayout(
      {required this.lamports,
      required this.sourceTransientStakeSeed,
      required this.ephemeralStakeSeed,
      required this.destinationTransientStakeSeed});

  factory StakePoolReDelegateLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: StakePoolProgramInstruction.redelegate.insturction);
    return StakePoolReDelegateLayout(
        lamports: decode["lamports"],
        sourceTransientStakeSeed: decode["sourceTransientStakeSeed"],
        ephemeralStakeSeed: decode["ephemeralStakeSeed"],
        destinationTransientStakeSeed: decode["destinationTransientStakeSeed"]);
  }

  @override
  StakePoolProgramInstruction get instruction =>
      StakePoolProgramInstruction.redelegate;
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.ns64(property: "lamports"),
    LayoutConst.ns64(property: "sourceTransientStakeSeed"),
    LayoutConst.ns64(property: "ephemeralStakeSeed"),
    LayoutConst.ns64(property: "destinationTransientStakeSeed")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "lamports": lamports,
      "sourceTransientStakeSeed": sourceTransientStakeSeed,
      "ephemeralStakeSeed": ephemeralStakeSeed,
      "destinationTransientStakeSeed": destinationTransientStakeSeed
    };
  }
}
