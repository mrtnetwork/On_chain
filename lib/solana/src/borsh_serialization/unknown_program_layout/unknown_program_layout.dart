import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/borsh_serialization/core/program_layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/instruction/instruction.dart';

/// Represents an unknown program layout.
class UnknownProgramLayout extends ProgramLayout {
  /// The data of the unknown program layout.
  UnknownProgramLayout(List<int> data) : data = data.asImmutableBytes;
  final BuBytes data;
  @override
  UnknownProgramInstruction get instruction =>
      UnknownProgramInstruction.unknown;

  @override
  StructLayout get layout =>
      LayoutConst.struct([LayoutConst.blob(data.length, property: 'data')]);

  /// Serializes the unknown program layout.
  @override
  Map<String, dynamic> serialize() {
    return {'data': data};
  }

  /// Converts the unknown program layout to bytes.
  @override
  BuBytes toBytes() {
    return data;
  }

  @override
  Map<String, dynamic> toJson() {
    return {'data': BytesUtils.toHexString(data, prefix: '0x')};
  }
}
