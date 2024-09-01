import 'package:on_chain/solana/src/instructions/spl_token_swap/layouts/layouts.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

abstract class SPLTokenSwapProgramLayout extends ProgramLayout {
  const SPLTokenSwapProgramLayout();
  @override
  SPLTokenSwapProgramInstruction get instruction;
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: "instruction")]);
  static ProgramLayout fromBytes(List<int> data) {
    final decode =
        ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
    final instruction =
        SPLTokenSwapProgramInstruction.getInstruction(decode["instruction"]);
    switch (instruction) {
      case SPLTokenSwapProgramInstruction.initSwap:
        return SPLTokenSwapInitSwapLayout.fromBuffer(data);
      case SPLTokenSwapProgramInstruction.depositSingleToken:
        return SPLTokenSwapDepositSingleTokenLayout.fromBuffer(data);
      case SPLTokenSwapProgramInstruction.depositToken:
        return SPLTokenSwapDepositLayout.fromBuffer(data);
      case SPLTokenSwapProgramInstruction.withdrawToken:
        return SPLTokenSwapWithdrawLayout.fromBuffer(data);
      case SPLTokenSwapProgramInstruction.withdrawSingleToken:
        return SPLTokenSwapWithdrawSingleTokenLayout.fromBuffer(data);
      case SPLTokenSwapProgramInstruction.swap:
        return SPLTokenSwapSwapLayout.fromBuffer(data);
      default:
        return UnknownProgramLayout(data);
    }
  }
}
