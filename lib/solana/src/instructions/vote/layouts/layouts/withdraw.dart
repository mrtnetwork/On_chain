import 'package:on_chain/solana/src/instructions/vote/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u32(property: "instruction"),
    LayoutConst.ns64(property: "lamports")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction => VoteProgramInstruction.withdraw.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"lamports": lamports};
  }
}
