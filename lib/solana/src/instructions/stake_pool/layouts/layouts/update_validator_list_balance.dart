import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
        noMerge: decode["noMerge"], startIndex: decode["startIndex"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u32("startIndex"),
    LayoutUtils.boolean(property: "noMerge")
  ]);
  @override
  Structure get layout => _layout;
  @override
  int get instruction =>
      StakePoolProgramInstruction.updateValidatorListBalance.insturction;
  @override
  Map<String, dynamic> serialize() {
    return {"startIndex": startIndex, "noMerge": noMerge};
  }
}
