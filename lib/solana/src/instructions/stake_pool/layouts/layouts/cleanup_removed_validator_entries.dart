import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
    return StakePoolCleanupRemovedValidatorEntriesLayout();
  }
  @override
  int get instruction =>
      StakePoolProgramInstruction.cleanupRemovedValidatorEntries.insturction;
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);
  @override
  Structure get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
