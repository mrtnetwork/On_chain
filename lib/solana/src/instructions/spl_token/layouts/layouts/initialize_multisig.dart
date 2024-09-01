// Manages the layout structure for initializing a multisignature account for an SPL token.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Initialize Multisig account layout.
class SPLTokenInitializeMultisigLayout extends SPLTokenProgramLayout {
  /// The number of signers required to validate this multisignature
  /// account.
  final int numberOfRequiredSignatures;

  /// Constructs an SPLTokenInitializeMultisigLayout instance.
  SPLTokenInitializeMultisigLayout({
    required this.numberOfRequiredSignatures,
  });

  /// StructLayout structure for initializing a multisignature account.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u8(property: "numberOfRequiredSignatures")
  ]);

  /// Constructs an SPLTokenInitializeMultisigLayout instance from buffer.
  factory SPLTokenInitializeMultisigLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.initializeMultisig.insturction,
    );
    return SPLTokenInitializeMultisigLayout(
      numberOfRequiredSignatures: decode["numberOfRequiredSignatures"],
    );
  }

  /// Returns the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.initializeMultisig;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {"numberOfRequiredSignatures": numberOfRequiredSignatures};
  }
}
