// Manages the layout structure for initializing an SPL token with an immutable owner.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Initialize the Immutable Owner layout.
class SPLTokenInitializeImmutableOwnerLayout extends SPLTokenProgramLayout {
  /// Constructs an SPLTokenInitializeImmutableOwnerLayout instance.
  SPLTokenInitializeImmutableOwnerLayout();

  /// Structure structure for SPLTokenInitializeImmutableOwnerLayout.
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

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
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction =
      SPLTokenProgramInstruction.initializeImmutableOwner.insturction;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
