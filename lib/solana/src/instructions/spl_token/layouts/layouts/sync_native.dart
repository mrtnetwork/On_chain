// Manages the layout structure for syncing native tokens in SPL.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// sync Native layout.
class SPLTokenSyncNativeLayout extends SPLTokenProgramLayout {
  /// Constructs an SPLTokenSyncNativeLayout instance.
  SPLTokenSyncNativeLayout();

  /// StructLayout structure for syncing native tokens in SPL.
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: "instruction")]);

  /// Constructs an SPLTokenSyncNativeLayout instance from buffer.
  factory SPLTokenSyncNativeLayout.fromBuffer(List<int> bytes) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.syncNative.insturction);
    return SPLTokenSyncNativeLayout();
  }

  /// Returns the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction = SPLTokenProgramInstruction.syncNative.insturction;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
