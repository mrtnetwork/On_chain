import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Withdraw collateral from an obligation layout
class TokenLendingWithdrawObligationCollateralLayout
    extends TokenLendingProgramLayout {
  /// Amount of collateral tokens to withdraw - u64::MAX for up to 100% of
  /// deposited amount
  final BigInt collateralAmount;
  const TokenLendingWithdrawObligationCollateralLayout(
      {required this.collateralAmount});

  factory TokenLendingWithdrawObligationCollateralLayout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: TokenLendingProgramInstruction
            .withdrawObligationCollateral.insturction);
    return TokenLendingWithdrawObligationCollateralLayout(
        collateralAmount: decode['collateralAmount']);
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u64(property: 'collateralAmount')
  ]);
  @override
  StructLayout get layout => _layout;

  @override
  TokenLendingProgramInstruction get instruction =>
      TokenLendingProgramInstruction.withdrawObligationCollateral;

  @override
  Map<String, dynamic> serialize() {
    return {'collateralAmount': collateralAmount};
  }
}
