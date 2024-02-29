// Manages the layout structure for closing an SPL token account.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Represents the layout for closing an SPL token account.
class SPLTokenCloseAccountLayout extends SPLTokenProgramLayout {
  /// Constructs an SPLTokenCloseAccountLayout instance.
  SPLTokenCloseAccountLayout();

  /// Structure structure for SPLTokenCloseAccountLayout.
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

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
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction = SPLTokenProgramInstruction.closeAccount.insturction;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
