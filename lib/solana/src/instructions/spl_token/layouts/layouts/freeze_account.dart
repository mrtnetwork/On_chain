// Manages the layout structure for freezing an SPL token account.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Freeze an Initialized account.
class SPLTokenFreezAccountLayout extends SPLTokenProgramLayout {
  /// Constructs an SPLTokenFreezAccountLayout instance.
  SPLTokenFreezAccountLayout();

  /// StructLayout structure for SPLTokenFreezAccountLayout.
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: "instruction")]);

  /// Constructs an SPLTokenFreezAccountLayout instance from buffer.
  factory SPLTokenFreezAccountLayout.fromBuffer(List<int> bytes) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.freezeAccount.insturction);
    return SPLTokenFreezAccountLayout();
  }

  /// Gets the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction = SPLTokenProgramInstruction.freezeAccount.insturction;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
