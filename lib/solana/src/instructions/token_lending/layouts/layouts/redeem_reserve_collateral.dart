import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Redeem collateral from a reserve in exchange for liquidity layout.
class TokenLendingRedeemReserveCollateralLayout
    extends TokenLendingProgramLayout {
  /// Amount of collateral tokens to redeem in exchange for liquidity
  final BigInt collateralAmount;
  const TokenLendingRedeemReserveCollateralLayout(
      {required this.collateralAmount});

  factory TokenLendingRedeemReserveCollateralLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            TokenLendingProgramInstruction.redeemReserveCollateral.insturction);
    return TokenLendingRedeemReserveCollateralLayout(
        collateralAmount: decode["collateralAmount"]);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u64(property: "collateralAmount"),
  ]);
  @override
  StructLayout get layout => _layout;

  @override
  int get instruction =>
      TokenLendingProgramInstruction.redeemReserveCollateral.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"collateralAmount": collateralAmount};
  }
}
