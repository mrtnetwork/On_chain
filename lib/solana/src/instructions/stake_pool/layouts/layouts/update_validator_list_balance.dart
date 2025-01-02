import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class StakePoolUpdateValidatorListBalanceLayout extends StakePoolProgramLayout {
  /// Index to start updating on the validator list
  final int startIndex;

  /// If true, don't try merging transient stake accounts into the reserve
  /// or validator stake account.  Useful for testing or if a
  /// particular stake account is in a bad state, but we still
  /// want to update
  final bool noMerge;
  const StakePoolUpdateValidatorListBalanceLayout(
      {required this.startIndex, required this.noMerge});

  factory StakePoolUpdateValidatorListBalanceLayout.fromBuffer(
      List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction:
            StakePoolProgramInstruction.updateValidatorListBalance.insturction);
    return StakePoolUpdateValidatorListBalanceLayout(
        noMerge: decode['noMerge'], startIndex: decode['startIndex']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u32(property: 'startIndex'),
    LayoutConst.boolean(property: 'noMerge')
  ]);
  @override
  StructLayout get layout => _layout;
  @override
  StakePoolProgramInstruction get instruction =>
      StakePoolProgramInstruction.updateValidatorListBalance;
  @override
  Map<String, dynamic> serialize() {
    return {'startIndex': startIndex, 'noMerge': noMerge};
  }
}
