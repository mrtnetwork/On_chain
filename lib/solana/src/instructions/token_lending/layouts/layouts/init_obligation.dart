import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class TokenLendingInitObligationLayout extends TokenLendingProgramLayout {
  const TokenLendingInitObligationLayout();

  factory TokenLendingInitObligationLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: TokenLendingProgramInstruction.initObligation.insturction);
    return const TokenLendingInitObligationLayout();
  }
  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);
  @override
  StructLayout get layout => _layout;

  @override
  TokenLendingProgramInstruction get instruction =>
      TokenLendingProgramInstruction.initObligation;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
