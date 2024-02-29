import 'package:blockchain_utils/binary/binary.dart';
import 'package:on_chain/solana/src/instructions/name_service/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
    Map<String, dynamic> decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: data,
      instruction: NameServiceProgramInstruction.update.insturction,
    );
    return NameServiceUpdateLayout(
      inputData: decode["inputData"],
      offset: decode["offset"],
    );
  }

  /// The layout structure.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u32("offset"),
    LayoutUtils.vecU8("inputData")
  ]);

  /// The layout structure.
  @override
  Structure get layout => _layout;

  /// The instruction associated with the layout.
  @override
  int get instruction => NameServiceProgramInstruction.update.insturction;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {"inputData": inputData, "offset": offset};
  }
}
