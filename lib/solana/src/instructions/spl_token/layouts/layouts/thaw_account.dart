// Manages the layout structure for thawing an account in SPL.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Thaw a Frozen account layout.
class SPLTokenThawAccountLayout extends SPLTokenProgramLayout {
  /// Constructs an SPLTokenThawAccountLayout instance.
  SPLTokenThawAccountLayout();

  /// StructLayout structure for thawing an account in SPL.
  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

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
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.thawAccount;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
