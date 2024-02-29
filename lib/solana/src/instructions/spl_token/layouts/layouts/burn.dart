// Manages the layout structure for the SPL token burn operation.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Burns tokens by removing them from an account layout.
class SPLTokenBurnLayout extends SPLTokenProgramLayout {
  /// The amount of tokens to burn.
  final BigInt amount;

  /// Constructs an SPLTokenBurnLayout instance.
  SPLTokenBurnLayout({
    required this.amount,
  });

  /// Structure structure for SPLTokenBurnLayout.
  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), LayoutUtils.u64("amount")]);

  /// Constructs an SPLTokenBurnLayout instance from buffer.
  factory SPLTokenBurnLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.burn.insturction);
    return SPLTokenBurnLayout(amount: decode["amount"]);
  }

  /// Gets the layout structure.
  @override
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction = SPLTokenProgramInstruction.burn.insturction;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {"amount": amount};
  }
}
