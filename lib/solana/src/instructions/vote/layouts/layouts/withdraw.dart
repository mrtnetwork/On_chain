import 'package:on_chain/solana/src/instructions/vote/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Withdraw from vote account layoyt
class VoteProgramWithdrawLayout extends VoteProgramLayout {
  final BigInt lamports;
  const VoteProgramWithdrawLayout({required this.lamports});
  factory VoteProgramWithdrawLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: VoteProgramInstruction.withdraw.insturction);
    return VoteProgramWithdrawLayout(lamports: decode["lamports"]);
  }
  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u32("instruction"), LayoutUtils.ns64("lamports")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => VoteProgramInstruction.withdraw.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"lamports": lamports};
  }
}
