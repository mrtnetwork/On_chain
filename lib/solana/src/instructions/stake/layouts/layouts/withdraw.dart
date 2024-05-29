import 'package:on_chain/solana/src/instructions/stake/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u32(property: "instruction"),
    LayoutConst.ns64(property: "lamports")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction => StakeProgramInstruction.withdraw.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"lamports": lamports};
  }
}
