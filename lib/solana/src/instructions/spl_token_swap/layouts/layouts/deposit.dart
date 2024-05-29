import 'package:on_chain/solana/src/instructions/spl_token_swap/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Deposit both types of tokens into the pool layoyt.
class SPLTokenSwapDepositLayout extends SPLTokenSwapProgramLayout {
  /// Pool token amount to transfer. token_a and token_b amount are set by
  /// the current exchange rate and size of the pool
  final BigInt poolTokenAmount;

  /// Maximum token A amount to deposit, prevents excessive slippage
  final BigInt maximumTokenA;

  /// Maximum token B amount to deposit, prevents excessive slippage
  final BigInt maximumTokenB;

  /// Constructs a `SPLTokenSwapDepositLayout` instance with the given parameters.
  const SPLTokenSwapDepositLayout({
    required this.poolTokenAmount,
    required this.maximumTokenA,
    required this.maximumTokenB,
  });

  /// Constructs a `SPLTokenSwapDepositLayout` instance from the given byte array.
  factory SPLTokenSwapDepositLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenSwapProgramInstruction.depositToken.insturction,
    );

    return SPLTokenSwapDepositLayout(
      poolTokenAmount: decode["poolTokenAmount"],
      maximumTokenA: decode["maximumTokenA"],
      maximumTokenB: decode["maximumTokenB"],
    );
  }

  /// The layout structure for depositing tokens.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u64(property: 'poolTokenAmount'),
    LayoutConst.u64(property: 'maximumTokenA'),
    LayoutConst.u64(property: 'maximumTokenB'),
  ]);
  @override
  StructLayout get layout => _layout;

  @override
  int get instruction =>
      SPLTokenSwapProgramInstruction.depositToken.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "poolTokenAmount": poolTokenAmount,
      "maximumTokenA": maximumTokenA,
      "maximumTokenB": maximumTokenB,
    };
  }
}
