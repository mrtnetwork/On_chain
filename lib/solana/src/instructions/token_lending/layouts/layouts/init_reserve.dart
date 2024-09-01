import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/token_lending/layouts/types/reserve_confing.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u64(property: "liquidityAmount"),
    ReserveConfig.layout
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  TokenLendingProgramInstruction get instruction =>
      TokenLendingProgramInstruction.initReserve;

  @override
  Map<String, dynamic> serialize() {
    return {"liquidityAmount": liquidityAmount, "config": config.serialize()};
  }
}
