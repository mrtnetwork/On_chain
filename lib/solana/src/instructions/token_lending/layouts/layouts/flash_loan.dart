import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Make a flash loan layout.
class TokenLendingFlashLoanLayout extends TokenLendingProgramLayout {
  /// The amount that is to be borrowed
  final BigInt liquidityAmount;
  const TokenLendingFlashLoanLayout({required this.liquidityAmount});

  factory TokenLendingFlashLoanLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: TokenLendingProgramInstruction.flashLoan.insturction);
    return TokenLendingFlashLoanLayout(
        liquidityAmount: decode["liquidityAmount"]);
  }
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u64("liquidityAmount"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => TokenLendingProgramInstruction.flashLoan.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"liquidityAmount": liquidityAmount};
  }
}
