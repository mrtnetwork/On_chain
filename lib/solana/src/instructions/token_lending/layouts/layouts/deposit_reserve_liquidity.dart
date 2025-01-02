import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Deposit liquidity into a reserve in exchange for collateral layout.
class TokenLendingDepositReserveLiquidityLayout
    extends TokenLendingProgramLayout {
  /// Amount of liquidity to deposit in exchange for collateral tokens
  final BigInt liquidityAmount;
  const TokenLendingDepositReserveLiquidityLayout(
      {required this.liquidityAmount});

  factory TokenLendingDepositReserveLiquidityLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            TokenLendingProgramInstruction.depositReserveLiquidity.insturction);
    return TokenLendingDepositReserveLiquidityLayout(
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
      TokenLendingProgramInstruction.depositReserveLiquidity;

  @override
  Map<String, dynamic> serialize() {
    return {'liquidityAmount': liquidityAmount};
  }
}
