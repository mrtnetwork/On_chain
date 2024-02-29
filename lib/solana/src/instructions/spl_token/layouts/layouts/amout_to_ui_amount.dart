// Manages the layout structure for converting SPL token amount to UI amount.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Convert an Amount of tokens to a UiAmount layout.
class SPLTokenAmountToUiAmountLayout extends SPLTokenProgramLayout {
  /// The amount of tokens to reformat.
  final BigInt amount;

  /// Constructs an SPLTokenAmountToUiAmountLayout instance.
  SPLTokenAmountToUiAmountLayout({required this.amount});

  /// Structure structure for SPLTokenAmountToUiAmountLayout.
  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), LayoutUtils.u64("amount")]);

  /// Constructs an SPLTokenAmountToUiAmountLayout instance from buffer.
  factory SPLTokenAmountToUiAmountLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.amountToUiAmount.insturction);
    return SPLTokenAmountToUiAmountLayout(amount: decode["amount"]);
  }

  /// Gets the layout structure.
  @override
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction =
      SPLTokenProgramInstruction.amountToUiAmount.insturction;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {"amount": amount};
  }
}
