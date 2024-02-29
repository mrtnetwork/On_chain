// Manages the layout structure for syncing native tokens in SPL.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// sync Native layout.
class SPLTokenSyncNativeLayout extends SPLTokenProgramLayout {
  /// Constructs an SPLTokenSyncNativeLayout instance.
  SPLTokenSyncNativeLayout();

  /// Structure structure for syncing native tokens in SPL.
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

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
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction = SPLTokenProgramInstruction.syncNative.insturction;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
