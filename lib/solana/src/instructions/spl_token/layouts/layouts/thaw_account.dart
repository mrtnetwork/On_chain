// Manages the layout structure for thawing an account in SPL.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Thaw a Frozen account layout.
class SPLTokenThawAccountLayout extends SPLTokenProgramLayout {
  /// Constructs an SPLTokenThawAccountLayout instance.
  SPLTokenThawAccountLayout();

  /// Structure structure for thawing an account in SPL.
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  /// Constructs an SPLTokenThawAccountLayout instance from buffer.
  factory SPLTokenThawAccountLayout.fromBuffer(List<int> bytes) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.thawAccount.insturction);
    return SPLTokenThawAccountLayout();
  }

  /// Returns the layout structure.
  @override
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction = SPLTokenProgramInstruction.thawAccount.insturction;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
