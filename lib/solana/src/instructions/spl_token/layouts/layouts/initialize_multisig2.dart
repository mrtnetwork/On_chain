// Manages the layout structure for initializing a multisignature account
// (v2, without the rent sysvar) for an SPL token.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/encoding/encoding.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// InitializeMultisig2 layout (instruction 19). Same payload as
/// v1 (required-signatures count) but the transaction omits the rent sysvar.
class SPLTokenInitializeMultisig2Layout extends SPLTokenProgramLayout {
  /// The number of signers required to validate this multisignature
  /// account.
  final int numberOfRequiredSignatures;

  /// Constructs an SPLTokenInitializeMultisig2Layout instance.
  SPLTokenInitializeMultisig2Layout({required this.numberOfRequiredSignatures});

  /// StructLayout structure for initializing a multisignature account (v2).
  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'numberOfRequiredSignatures'),
  ]);

  /// Constructs an SPLTokenInitializeMultisig2Layout instance from buffer.
  factory SPLTokenInitializeMultisig2Layout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.initializeMultisig2.instruction,
    );
    return SPLTokenInitializeMultisig2Layout(
      numberOfRequiredSignatures: decode['numberOfRequiredSignatures'],
    );
  }

  /// Returns the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.initializeMultisig2;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {'numberOfRequiredSignatures': numberOfRequiredSignatures};
  }
}
