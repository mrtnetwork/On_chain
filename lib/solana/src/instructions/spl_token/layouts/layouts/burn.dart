// Manages the layout structure for the SPL token burn operation.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Burns tokens by removing them from an account layout.
class SPLTokenBurnLayout extends SPLTokenProgramLayout {
  /// The amount of tokens to burn.
  final BigInt amount;

  /// Constructs an SPLTokenBurnLayout instance.
  SPLTokenBurnLayout({
    required this.amount,
  });

  /// StructLayout structure for SPLTokenBurnLayout.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u64(property: "amount")
  ]);

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
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction = SPLTokenProgramInstruction.burn.insturction;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {"amount": amount};
  }
}
