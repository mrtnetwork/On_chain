import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Repay borrowed liquidity to a reserve account.
class TokenLendingRepayObligationLiquidityLayout
    extends TokenLendingProgramLayout {
  /// Amount of liquidity to repay
  final BigInt liquidityAmount;
  const TokenLendingRepayObligationLiquidityLayout(
      {required this.liquidityAmount});

  factory TokenLendingRepayObligationLiquidityLayout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: TokenLendingProgramInstruction
            .repayObligationLiquidity.insturction);
    return TokenLendingRepayObligationLiquidityLayout(
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
      TokenLendingProgramInstruction.repayObligationLiquidity;

  @override
  Map<String, dynamic> serialize() {
    return {'liquidityAmount': liquidityAmount};
  }
}
