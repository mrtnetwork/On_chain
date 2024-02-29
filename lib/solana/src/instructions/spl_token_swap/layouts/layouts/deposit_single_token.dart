import 'package:on_chain/solana/src/instructions/spl_token_swap/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/core/core.dart';
import 'package:on_chain/solana/src/layout/program_layouts/core/program_layout.dart';
import 'package:on_chain/solana/src/layout/utils/layout_utils.dart';

/// Deposit one type of tokens into the pool layout.
class SPLTokenSwapDepositSingleTokenLayout extends SPLTokenSwapProgramLayout {
  /// Token amount to deposit
  final BigInt sourceTokenAmount;

  /// Pool token amount to receive in exchange. The amount is set by
  /// the current exchange rate and size of the pool
  final BigInt minimumPoolTokenAmount;

  /// Constructs a [SPLTokenSwapDepositSingleTokenLayout] instance with the given parameters.
  const SPLTokenSwapDepositSingleTokenLayout({
    required this.sourceTokenAmount,
    required this.minimumPoolTokenAmount,
  });

  /// Constructs a [SPLTokenSwapDepositSingleTokenLayout] instance from the given byte array.
  factory SPLTokenSwapDepositSingleTokenLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction:
          SPLTokenSwapProgramInstruction.depositSingleToken.insturction,
    );

    return SPLTokenSwapDepositSingleTokenLayout(
      sourceTokenAmount: decode["sourceTokenAmount"],
      minimumPoolTokenAmount: decode["minimumPoolTokenAmount"],
    );
  }

  /// The layout structure for depositing a single token.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8('instruction'),
    LayoutUtils.u64('sourceTokenAmount'),
    LayoutUtils.u64('minimumPoolTokenAmount'),
  ]);
  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      SPLTokenSwapProgramInstruction.depositSingleToken.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "sourceTokenAmount": sourceTokenAmount,
      "minimumPoolTokenAmount": minimumPoolTokenAmount,
    };
  }
}
