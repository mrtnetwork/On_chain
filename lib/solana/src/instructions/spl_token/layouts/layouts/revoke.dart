// Manages the layout structure for revoking SPL tokens.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Revokes the delegate's authority layout.
class SPLTokenRevokeLayout extends SPLTokenProgramLayout {
  /// Constructs an SPLTokenRevokeLayout instance.
  SPLTokenRevokeLayout();

  /// StructLayout structure for revoking SPL tokens.
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

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
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.revoke;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
