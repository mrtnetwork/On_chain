import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Repay borrowed liquidity to a reserve to receive collateral at a
/// discount from an unhealthy obligation layout.
class TokenLendingLiquidateObligationLayout extends TokenLendingProgramLayout {
  /// Amount of liquidity to repay - u64::MAX for up to 100% of borrowed
  /// amount
  final BigInt liquidityAmount;
  const TokenLendingLiquidateObligationLayout({required this.liquidityAmount});

  factory TokenLendingLiquidateObligationLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            TokenLendingProgramInstruction.liquidateObligation.insturction);
    return TokenLendingLiquidateObligationLayout(
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
      TokenLendingProgramInstruction.liquidateObligation;

  @override
  Map<String, dynamic> serialize() {
    return {'liquidityAmount': liquidityAmount};
  }
}
