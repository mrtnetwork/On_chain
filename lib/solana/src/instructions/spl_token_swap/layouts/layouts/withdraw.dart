import 'package:on_chain/solana/src/instructions/spl_token_swap/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Withdraw both types of tokens from the pool layout.
class SPLTokenSwapWithdrawLayout extends SPLTokenSwapProgramLayout {
  /// Amount of pool tokens to burn. User receives an output of token a
  /// and b based on the percentage of the pool tokens that are returned.
  final BigInt poolTokenAmount;

  /// Minimum amount of token A to receive, prevents excessive slippage
  final BigInt minimumTokenA;

  /// Minimum amount of token B to receive, prevents excessive slippage
  final BigInt minimumTokenB;

  /// Constructs a [SPLTokenSwapWithdrawLayout] instance with the given parameters.
  const SPLTokenSwapWithdrawLayout({
    required this.poolTokenAmount,
    required this.minimumTokenA,
    required this.minimumTokenB,
  });

  /// Constructs a [SPLTokenSwapWithdrawLayout] instance from the given byte array.
  factory SPLTokenSwapWithdrawLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenSwapProgramInstruction.withdrawToken.insturction,
    );

    return SPLTokenSwapWithdrawLayout(
      poolTokenAmount: decode["poolTokenAmount"],
      minimumTokenA: decode["minimumTokenA"],
      minimumTokenB: decode["minimumTokenB"],
    );
  }

  /// The layout structure for withdrawing tokens.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8('instruction'),
    LayoutUtils.u64('poolTokenAmount'),
    LayoutUtils.u64('minimumTokenA'),
    LayoutUtils.u64('minimumTokenB'),
  ]);
  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      SPLTokenSwapProgramInstruction.withdrawToken.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "poolTokenAmount": poolTokenAmount,
      "minimumTokenA": minimumTokenA,
      "minimumTokenB": minimumTokenB,
    };
  }
}
