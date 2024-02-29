// Manages the layout structure for revoking SPL tokens.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Revokes the delegate's authority layout.
class SPLTokenRevokeLayout extends SPLTokenProgramLayout {
  /// Constructs an SPLTokenRevokeLayout instance.
  SPLTokenRevokeLayout();

  /// Structure structure for revoking SPL tokens.
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  /// Constructs an SPLTokenRevokeLayout instance from buffer.
  factory SPLTokenRevokeLayout.fromBuffer(List<int> bytes) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.revoke.insturction);
    return SPLTokenRevokeLayout();
  }

  /// Returns the layout structure.
  @override
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction = SPLTokenProgramInstruction.revoke.insturction;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
