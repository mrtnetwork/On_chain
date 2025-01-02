import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/solana/src/instructions/name_service/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

///  Update the data in a name record.
class NameServiceUpdateLayout extends NameServiceProgramLayout {
  /// The data to be written.
  final List<int> inputData;

  /// The offset to which the data should be written into the registry
  final int offset;

  /// Constructs a NameServiceUpdateLayout instance with the specified input data and offset.
  NameServiceUpdateLayout({required List<int> inputData, required this.offset})
      : inputData = BytesUtils.toBytes(inputData, unmodifiable: true);

  /// Creates a NameServiceUpdateLayout instance from buffer data.
  factory NameServiceUpdateLayout.fromBuffer(List<int> data) {
    final Map<String, dynamic> decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: data,
      instruction: NameServiceProgramInstruction.update.insturction,
    );
    return NameServiceUpdateLayout(
      inputData: decode['inputData'],
      offset: decode['offset'],
    );
  }

  /// The layout structure.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u32(property: 'offset'),
    LayoutConst.vecU8(property: 'inputData')
  ]);

  /// The layout structure.
  @override
  StructLayout get layout => _layout;

  /// The instruction associated with the layout.
  @override
  NameServiceProgramInstruction get instruction =>
      NameServiceProgramInstruction.update;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {'inputData': inputData, 'offset': offset};
  }
}
