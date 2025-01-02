// Manages the layout structure for reallocating SPL token extensions.
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/spl_token/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// use reallocation to increase the data size layout.
class SPLTokenReallocateLayout extends SPLTokenProgramLayout {
  /// Constructs an SPLTokenReallocateLayout instance.
  SPLTokenReallocateLayout({required List<ExtensionType> extensionTypes})
      : extensionTypes = List<ExtensionType>.unmodifiable(extensionTypes);

  /// StructLayout structure for reallocating SPL token extensions.
  static StructLayout _layout({required int length}) => LayoutConst.struct([
        LayoutConst.u8(property: 'instruction'),
        LayoutConst.array(LayoutConst.u16(), length, property: 'extensionTypes')
      ]);

  /// Constructs an SPLTokenReallocateLayout instance from buffer.
  factory SPLTokenReallocateLayout.fromBuffer(List<int> bytes) {
    final length = (bytes.length - 1) ~/ 2;
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout(length: length),
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.reallocate.insturction);

    return SPLTokenReallocateLayout(
        extensionTypes: (decode['extensionTypes'] as List)
            .map((e) => ExtensionType.fromValue(e))
            .toList());
  }

  /// Returns the layout structure.
  @override
  late final StructLayout layout = _layout(length: extensionTypes.length);

  /// New extension types to include in the reallocated account
  final List<ExtensionType> extensionTypes;

  /// Instruction associated with the layout.
  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.reallocate;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {'extensionTypes': extensionTypes.map((e) => e.value).toList()};
  }
}
