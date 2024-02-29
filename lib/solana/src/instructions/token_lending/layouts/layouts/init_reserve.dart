import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/token_lending/layouts/types/reserve_confing.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Initializes a new lending market reserve layout.
class TokenLendingInitReserveLayout extends TokenLendingProgramLayout {
  /// Initial amount of liquidity to deposit into the new reserve
  final BigInt liquidityAmount;

  /// Reserve configuration values
  final ReserveConfig config;
  const TokenLendingInitReserveLayout(
      {required this.liquidityAmount, required this.config});

  factory TokenLendingInitReserveLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: TokenLendingProgramInstruction.initReserve.insturction);

    return TokenLendingInitReserveLayout(
        liquidityAmount: decode["liquidityAmount"],
        config: ReserveConfig.fromJson(decode["config"]));
  }
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u64("liquidityAmount"),
    ReserveConfig.layout
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => TokenLendingProgramInstruction.initReserve.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"liquidityAmount": liquidityAmount, "config": config.serialize()};
  }
}
