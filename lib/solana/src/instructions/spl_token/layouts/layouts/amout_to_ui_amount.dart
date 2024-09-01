// Manages the layout structure for converting SPL token amount to UI amount.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Convert an Amount of tokens to a UiAmount layout.
class SPLTokenAmountToUiAmountLayout extends SPLTokenProgramLayout {
  /// The amount of tokens to reformat.
  final BigInt amount;

  /// Constructs an SPLTokenAmountToUiAmountLayout instance.
  SPLTokenAmountToUiAmountLayout({required this.amount});

  /// StructLayout structure for SPLTokenAmountToUiAmountLayout.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u64(property: "amount")
  ]);

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
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.amountToUiAmount;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {"amount": amount};
  }
}
