import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Borrow liquidity from a reserve by depositing collateral tokens layout.
class TokenLendingBorrowObligationLiquidityLayout
    extends TokenLendingProgramLayout {
  /// Amount of liquidity to borrow.
  final BigInt liquidityAmount;
  const TokenLendingBorrowObligationLiquidityLayout(
      {required this.liquidityAmount});

  factory TokenLendingBorrowObligationLiquidityLayout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: TokenLendingProgramInstruction
            .borrowObligationLiquidity.insturction);
    return TokenLendingBorrowObligationLiquidityLayout(
        liquidityAmount: decode["liquidityAmount"]);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u64(property: "liquidityAmount"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction =>
      TokenLendingProgramInstruction.borrowObligationLiquidity.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"liquidityAmount": liquidityAmount};
  }
}
