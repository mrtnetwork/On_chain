import 'package:on_chain/solana/src/instructions/name_service/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Delete a name record.
class NameServiceDeleteLayout extends NameServiceProgramLayout {
  /// Constructs a NameServiceDeleteLayout instance.
  const NameServiceDeleteLayout();

  /// Creates a NameServiceDeleteLayout instance from buffer data.
  factory NameServiceDeleteLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: data,
      instruction: NameServiceProgramInstruction.delete.insturction,
    );
    return const NameServiceDeleteLayout();
  }

  /// The layout structure.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
  ]);

  /// The layout structure.
  @override
  StructLayout get layout => _layout;

  /// The instruction associated with the layout.
  @override
  int get instruction => NameServiceProgramInstruction.delete.insturction;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
