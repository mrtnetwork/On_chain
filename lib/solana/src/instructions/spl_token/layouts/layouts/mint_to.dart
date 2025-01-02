// Manages the layout structure for minting tokens for an SPL token.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Mints new tokens to an account layout.
class SPLTokenMintToLayout extends SPLTokenProgramLayout {
  /// The amount of new tokens to mint.
  final BigInt amount;

  /// Constructs an SPLTokenMintToLayout instance.
  SPLTokenMintToLayout({required this.amount});

  /// StructLayout structure for minting tokens.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u64(property: 'amount')
  ]);

  /// Constructs an SPLTokenMintToLayout instance from buffer.
  factory SPLTokenMintToLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.mintTo.insturction);

    return SPLTokenMintToLayout(amount: decode['amount']);
  }

  /// Returns the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.mintTo;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {'amount': amount};
  }
}
