import 'package:on_chain/solana/src/instructions/spl_token_swap/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Swap the tokens in the pool layout.
class SPLTokenSwapSwapLayout extends SPLTokenSwapProgramLayout {
  /// SOURCE amount to transfer, output to DESTINATION is based on the
  /// exchange rate
  final BigInt amountIn;

  /// Minimum amount of DESTINATION token to output, prevents excessive
  /// slippage
  final BigInt minimumAmountOut;

  /// Constructs a [SPLTokenSwapSwapLayout] instance with the given parameters.
  const SPLTokenSwapSwapLayout({
    required this.amountIn,
    required this.minimumAmountOut,
  });

  /// Constructs a [SPLTokenSwapSwapLayout] instance from the given byte array.
  factory SPLTokenSwapSwapLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenSwapProgramInstruction.swap.insturction,
    );

    return SPLTokenSwapSwapLayout(
      amountIn: decode["amountIn"],
      minimumAmountOut: decode["minimumAmountOut"],
    );
  }

  /// The layout structure for swapping tokens.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8('instruction'),
    LayoutUtils.u64('amountIn'),
    LayoutUtils.u64('minimumAmountOut'),
  ]);
  @override
  Structure get layout => _layout;

  @override
  int get instruction => SPLTokenSwapProgramInstruction.swap.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "amountIn": amountIn,
      "minimumAmountOut": minimumAmountOut,
    };
  }
}
