import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Abstract class for Borsh serializable programs.
abstract class ProgramLayout implements LayoutSerializable {
  const ProgramLayout();

  /// The layout representing the structure of the program.
  @override
  abstract final Structure layout;

  /// The instruction of the program.
  abstract final dynamic instruction;

  /// Serializes the program.
  @override
  Map<String, dynamic> serialize();

  /// Converts the program to bytes using Borsh serialization.
  @override
  List<int> toBytes() {
    final LayoutByteWriter data = LayoutByteWriter(layout.span);
    final size =
        layout.encode({"instruction": instruction, ...serialize()}, data);
    if (layout.span < 0) {
      return data.sublist(0, size);
    }
    return data.toBytes();
  }

  /// Converts the program to a hexadecimal string.
  @override
  String toHex() {
    return BytesUtils.toHexString(toBytes());
  }

  /// Decodes and validates Borsh serialized bytes.
  ///
  /// - [layout] : The layout representing the structure of the program.
  /// - [bytes] : The bytes to decode.
  /// - [instruction] (optional): The expected instruction index.
  /// - [discriminator] (optional): The expected discriminator.
  static Map<String, dynamic> decodeAndValidateStruct({
    required Structure layout,
    required List<int> bytes,
    int? instruction,
    int? discriminator,
  }) {
    final decode = layout.decode(bytes);
    if (instruction != null) {
      if (decode["instruction"] != instruction) {
        throw MessageException("invalid instruction index", details: {
          "excepted": instruction,
          "instruction": decode["instruction"]
        });
      }
    }
    if (discriminator != null) {
      if (decode["discriminator"] != discriminator) {
        throw MessageException("invalid discriminator", details: {
          "excepted": discriminator,
          "instruction": decode["discriminator"]
        });
      }
    }
    return decode;
  }
}
