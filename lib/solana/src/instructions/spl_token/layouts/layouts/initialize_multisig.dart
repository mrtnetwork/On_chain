// Manages the layout structure for initializing a multisignature account for an SPL token.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Initialize Multisig account layout.
class SPLTokenInitializeMultisigLayout extends SPLTokenProgramLayout {
  /// The number of signers required to validate this multisignature
  /// account.
  final int numberOfRequiredSignatures;

  /// Constructs an SPLTokenInitializeMultisigLayout instance.
  SPLTokenInitializeMultisigLayout({
    required this.numberOfRequiredSignatures,
  });

  /// Structure structure for initializing a multisignature account.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u8("numberOfRequiredSignatures")
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
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction =
      SPLTokenProgramInstruction.initializeMultisig.insturction;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {"numberOfRequiredSignatures": numberOfRequiredSignatures};
  }
}
