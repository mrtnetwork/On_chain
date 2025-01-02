import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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
        liquidityAmount: decode['liquidityAmount']);
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u64(property: 'liquidityAmount'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  TokenLendingProgramInstruction get instruction =>
      TokenLendingProgramInstruction.flashLoan;

  @override
  Map<String, dynamic> serialize() {
    return {'liquidityAmount': liquidityAmount};
  }
}
