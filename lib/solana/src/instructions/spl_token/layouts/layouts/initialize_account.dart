// Manages the layout structure for initializing an SPL token account.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Initializes a new account to hold tokens layout.
class SPLTokenInitializeAccountLayout extends SPLTokenProgramLayout {
  /// Constructs an SPLTokenInitializeAccountLayout instance.
  SPLTokenInitializeAccountLayout();

  /// Structure structure for SPLTokenInitializeAccountLayout.
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  /// Constructs an SPLTokenInitializeAccountLayout instance from buffer.
  factory SPLTokenInitializeAccountLayout.fromBuffer(List<int> bytes) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.initializeAccount.insturction);
    return SPLTokenInitializeAccountLayout();
  }

  /// Gets the layout structure.
  @override
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction =
      SPLTokenProgramInstruction.initializeAccount.insturction;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
