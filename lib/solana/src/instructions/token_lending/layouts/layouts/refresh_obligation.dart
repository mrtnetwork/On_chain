import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Refresh an obligation's layout.
class TokenLendingRefreshObligationLayout extends TokenLendingProgramLayout {
  const TokenLendingRefreshObligationLayout();

  factory TokenLendingRefreshObligationLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            TokenLendingProgramInstruction.refreshObligation.insturction);
    return TokenLendingRefreshObligationLayout();
  }
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);
  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      TokenLendingProgramInstruction.refreshObligation.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
