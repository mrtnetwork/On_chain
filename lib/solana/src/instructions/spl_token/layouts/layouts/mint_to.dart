// Manages the layout structure for minting tokens for an SPL token.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Mints new tokens to an account layout.
class SPLTokenMintToLayout extends SPLTokenProgramLayout {
  /// The amount of new tokens to mint.
  final BigInt amount;

  /// Constructs an SPLTokenMintToLayout instance.
  SPLTokenMintToLayout({required this.amount});

  /// Structure structure for minting tokens.
  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), LayoutUtils.u64("amount")]);

  /// Constructs an SPLTokenMintToLayout instance from buffer.
  factory SPLTokenMintToLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.mintTo.insturction);

    return SPLTokenMintToLayout(amount: decode["amount"]);
  }

  /// Returns the layout structure.
  @override
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction = SPLTokenProgramInstruction.mintTo.insturction;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {"amount": amount};
  }
}
