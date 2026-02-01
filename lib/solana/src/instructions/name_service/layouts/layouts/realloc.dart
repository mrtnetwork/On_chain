import 'package:on_chain/solana/src/instructions/name_service/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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
    return NameServiceReallocLayout(space: decode['space']);
  }

  /// The layout structure.
  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u8(property: 'instruction'),
        LayoutConst.u32(property: 'space'),
      ]);

  /// The layout structure.
  @override
  StructLayout get layout => _layout;

  /// The instruction associated with the layout.
  @override
  NameServiceProgramInstruction get instruction =>
      NameServiceProgramInstruction.realloc;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {'space': space};
  }
}
