// Manages the layout structure for closing an SPL token account.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Represents the layout for closing an SPL token account.
class SPLTokenCloseAccountLayout extends SPLTokenProgramLayout {
  /// Constructs an SPLTokenCloseAccountLayout instance.
  SPLTokenCloseAccountLayout();

  /// StructLayout structure for SPLTokenCloseAccountLayout.
  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

  /// Constructs an SPLTokenCloseAccountLayout instance from buffer.
  factory SPLTokenCloseAccountLayout.fromBuffer(List<int> bytes) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.closeAccount.insturction);
    return SPLTokenCloseAccountLayout();
  }

  /// Gets the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.closeAccount;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
