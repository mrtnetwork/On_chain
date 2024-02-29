// Manages the layout structure for creating a native SPL token mint.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Creates the native mint layout.
class SPLTokenCreateNativeMintLayout extends SPLTokenProgramLayout {
  /// Constructs an SPLTokenCreateNativeMintLayout instance.
  SPLTokenCreateNativeMintLayout();

  /// Structure structure for SPLTokenCreateNativeMintLayout.
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  /// Constructs an SPLTokenCreateNativeMintLayout instance from buffer.
  factory SPLTokenCreateNativeMintLayout.fromBuffer(List<int> bytes) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.createNativeMint.insturction);
    return SPLTokenCreateNativeMintLayout();
  }

  /// Gets the layout structure.
  @override
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction =
      SPLTokenProgramInstruction.createNativeMint.insturction;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
