import 'package:on_chain/solana/src/instructions/name_service/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
    return NameServiceDeleteLayout();
  }

  /// The layout structure.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
  ]);

  /// The layout structure.
  @override
  Structure get layout => _layout;

  /// The instruction associated with the layout.
  @override
  int get instruction => NameServiceProgramInstruction.delete.insturction;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
