import 'package:on_chain/solana/src/instructions/stake/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class StakeWithdrawLayout extends StakeProgramLayout {
  final BigInt lamports;

  const StakeWithdrawLayout._(this.lamports);

  factory StakeWithdrawLayout({required BigInt lamports}) {
    return StakeWithdrawLayout._(lamports);
  }
  factory StakeWithdrawLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: StakeProgramInstruction.withdraw.insturction);
    return StakeWithdrawLayout._(decode["lamports"]);
  }
  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u32("instruction"), LayoutUtils.ns64("lamports")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => StakeProgramInstruction.withdraw.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"lamports": lamports};
  }
}
