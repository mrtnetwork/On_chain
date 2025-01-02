import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Refresh an obligation's layout.
class TokenLendingRefreshObligationLayout extends TokenLendingProgramLayout {
  const TokenLendingRefreshObligationLayout();

  factory TokenLendingRefreshObligationLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            TokenLendingProgramInstruction.refreshObligation.insturction);
    return const TokenLendingRefreshObligationLayout();
  }
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);
  @override
  StructLayout get layout => _layout;

  @override
  TokenLendingProgramInstruction get instruction =>
      TokenLendingProgramInstruction.refreshObligation;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
