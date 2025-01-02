import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Deposit collateral to an obligation layout.
class TokenLendingDepositObligationCollateralLayout
    extends TokenLendingProgramLayout {
  /// Amount of collateral tokens to deposit
  final BigInt collateralAmount;
  const TokenLendingDepositObligationCollateralLayout(
      {required this.collateralAmount});

  factory TokenLendingDepositObligationCollateralLayout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: TokenLendingProgramInstruction
            .depositObligationCollateral.insturction);
    return TokenLendingDepositObligationCollateralLayout(
        collateralAmount: decode['collateralAmount']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u64(property: 'collateralAmount'),
  ]);
  @override
  StructLayout get layout => _layout;

  @override
  TokenLendingProgramInstruction get instruction =>
      TokenLendingProgramInstruction.depositObligationCollateral;

  @override
  Map<String, dynamic> serialize() {
    return {'collateralAmount': collateralAmount};
  }
}
