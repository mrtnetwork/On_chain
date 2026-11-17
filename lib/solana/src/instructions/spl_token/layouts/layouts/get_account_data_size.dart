// Manages the layout structure for querying an SPL token account data size.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/encoding/encoding.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// GetAccountDataSize layout (instruction 21, Token-2022 only).
/// No payload; the mint account is passed as the single account.
class SPLTokenGetAccountDataSizeLayout extends SPLTokenProgramLayout {
  const SPLTokenGetAccountDataSizeLayout();

  /// StructLayout structure (instruction byte only).
  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

  /// Constructs an SPLTokenGetAccountDataSizeLayout instance from buffer.
  factory SPLTokenGetAccountDataSizeLayout.fromBuffer(List<int> bytes) {
    ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.getAccountDataSize.instruction,
    );
    return const SPLTokenGetAccountDataSizeLayout();
  }

  /// Returns the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.getAccountDataSize;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
