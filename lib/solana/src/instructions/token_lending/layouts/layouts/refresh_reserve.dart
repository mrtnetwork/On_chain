import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class TokenLendingRefreshReserveLayout extends TokenLendingProgramLayout {
  const TokenLendingRefreshReserveLayout();

  factory TokenLendingRefreshReserveLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: TokenLendingProgramInstruction.refreshReserve.insturction);
    return TokenLendingRefreshReserveLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);
  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      TokenLendingProgramInstruction.refreshReserve.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
