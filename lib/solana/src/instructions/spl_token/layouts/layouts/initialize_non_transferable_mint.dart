// Manages the layout structure for initializing a non-transferable mint for an SPL token.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Initialize the non transferable extension for the given mint account layout.
class SPLTokenInitializeNonTransferableMintLayout
    extends SPLTokenProgramLayout {
  /// Constructs an SPLTokenInitializeNonTransferableMintLayout instance.
  SPLTokenInitializeNonTransferableMintLayout();

  /// StructLayout structure for initializing a non-transferable mint.
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: "instruction")]);

  /// Constructs an SPLTokenInitializeNonTransferableMintLayout instance from buffer.
  factory SPLTokenInitializeNonTransferableMintLayout.fromBuffer(
      List<int> bytes) {
    ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction:
          SPLTokenProgramInstruction.initializeNonTransferableMint.insturction,
    );
    return SPLTokenInitializeNonTransferableMintLayout();
  }

  /// Returns the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.initializeNonTransferableMint;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
