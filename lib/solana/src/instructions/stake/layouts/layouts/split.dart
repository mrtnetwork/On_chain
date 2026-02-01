import 'package:on_chain/solana/src/instructions/stake/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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
    return StakeSplitLayout(lamports: decode['lamports']);
  }
  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u32(property: 'instruction'),
        LayoutConst.ns64(property: 'lamports')
      ]);
  @override
  StructLayout get layout => _layout;

  @override
  StakeProgramInstruction get instruction => StakeProgramInstruction.split;

  @override
  Map<String, dynamic> serialize() {
    return {'lamports': lamports};
  }
}
