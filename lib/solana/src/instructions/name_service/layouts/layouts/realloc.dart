import 'package:on_chain/solana/src/instructions/name_service/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Realloc the data of a name record.
class NameServiceReallocLayout extends NameServiceProgramLayout {
  /// New total number of bytes in addition to the [NameRecordHeader].
  /// There are no checks on the existing data; it will be truncated if
  /// the new space is less than the current space.
  final int space;

  /// Constructs a NameServiceReallocLayout instance with the specified space.
  const NameServiceReallocLayout({required this.space});

  /// Creates a NameServiceReallocLayout instance from buffer data.
  factory NameServiceReallocLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: data,
      instruction: NameServiceProgramInstruction.realloc.insturction,
    );
    return NameServiceReallocLayout(space: decode["space"]);
  }

  /// The layout structure.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u32("space"),
  ]);

  /// The layout structure.
  @override
  Structure get layout => _layout;

  /// The instruction associated with the layout.
  @override
  @override
  int get instruction => NameServiceProgramInstruction.realloc.insturction;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {"space": space};
  }
}
