// Manages the layout structure for creating a native SPL token mint.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Creates the native mint layout.
class SPLTokenCreateNativeMintLayout extends SPLTokenProgramLayout {
  /// Constructs an SPLTokenCreateNativeMintLayout instance.
  SPLTokenCreateNativeMintLayout();

  /// StructLayout structure for SPLTokenCreateNativeMintLayout.
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

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
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.createNativeMint;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
