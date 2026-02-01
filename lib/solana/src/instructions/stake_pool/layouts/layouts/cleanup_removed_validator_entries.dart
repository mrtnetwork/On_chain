import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Cleans up validator stake account entries layout.
class StakePoolCleanupRemovedValidatorEntriesLayout
    extends StakePoolProgramLayout {
  const StakePoolCleanupRemovedValidatorEntriesLayout();

  factory StakePoolCleanupRemovedValidatorEntriesLayout.fromBuffer(
      List<int> bytes) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: StakePoolProgramInstruction
            .cleanupRemovedValidatorEntries.insturction);
    return const StakePoolCleanupRemovedValidatorEntriesLayout();
  }
  @override
  StakePoolProgramInstruction get instruction =>
      StakePoolProgramInstruction.cleanupRemovedValidatorEntries;
  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);
  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
