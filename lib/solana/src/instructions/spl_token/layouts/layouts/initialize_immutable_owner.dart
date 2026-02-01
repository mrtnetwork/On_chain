// Manages the layout structure for initializing an SPL token with an immutable owner.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Initialize the Immutable Owner layout.
class SPLTokenInitializeImmutableOwnerLayout extends SPLTokenProgramLayout {
  /// Constructs an SPLTokenInitializeImmutableOwnerLayout instance.
  SPLTokenInitializeImmutableOwnerLayout();

  /// StructLayout structure for SPLTokenInitializeImmutableOwnerLayout.
  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

  /// Constructs an SPLTokenInitializeImmutableOwnerLayout instance from buffer.
  factory SPLTokenInitializeImmutableOwnerLayout.fromBuffer(List<int> bytes) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction:
            SPLTokenProgramInstruction.initializeImmutableOwner.insturction);
    return SPLTokenInitializeImmutableOwnerLayout();
  }

  /// Gets the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.initializeImmutableOwner;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
