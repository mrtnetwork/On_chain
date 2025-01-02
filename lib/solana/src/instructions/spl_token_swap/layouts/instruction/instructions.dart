import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/spl_token_swap/constant.dart';

class SPLTokenSwapProgramInstruction implements ProgramLayoutInstruction {
  @override
  final int insturction;
  @override
  final String name;
  const SPLTokenSwapProgramInstruction(this.insturction, this.name);
  static const SPLTokenSwapProgramInstruction initSwap =
      SPLTokenSwapProgramInstruction(0, 'InitSwap');
  static const SPLTokenSwapProgramInstruction swap =
      SPLTokenSwapProgramInstruction(1, 'Swap');
  static const SPLTokenSwapProgramInstruction depositToken =
      SPLTokenSwapProgramInstruction(2, 'DepositToken');
  static const SPLTokenSwapProgramInstruction withdrawToken =
      SPLTokenSwapProgramInstruction(3, 'WithdrawToken');
  static const SPLTokenSwapProgramInstruction depositSingleToken =
      SPLTokenSwapProgramInstruction(4, 'DepositSingleToken');
  static const SPLTokenSwapProgramInstruction withdrawSingleToken =
      SPLTokenSwapProgramInstruction(5, 'WithdrawSingleToken');
  static const List<SPLTokenSwapProgramInstruction> values = [
    initSwap,
    swap,
    depositToken,
    withdrawToken,
    depositSingleToken,
    withdrawSingleToken
  ];
  static SPLTokenSwapProgramInstruction? getInstruction(dynamic value) {
    try {
      return values.firstWhere((element) => element.insturction == value);
    } catch (_) {
      return null;
    }
  }

  @override
  String get programName => 'SPLTokenSwap';

  @override
  SolAddress get programAddress => SPLTokenSwapConst.tokenSwapProgramId;
}
