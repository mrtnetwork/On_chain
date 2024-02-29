import 'package:on_chain/solana/src/instructions/stake/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class StakeSplitLayout extends StakeProgramLayout {
  final BigInt lamports;

  const StakeSplitLayout._({required this.lamports});

  factory StakeSplitLayout({required BigInt lamports}) {
    return StakeSplitLayout._(lamports: lamports);
  }
  factory StakeSplitLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: StakeProgramInstruction.split.insturction);
    return StakeSplitLayout(lamports: decode["lamports"]);
  }
  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u32("instruction"), LayoutUtils.ns64("lamports")]);
  @override
  Structure get layout => _layout;

  @override
  int get instruction => StakeProgramInstruction.split.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"lamports": lamports};
  }
}
