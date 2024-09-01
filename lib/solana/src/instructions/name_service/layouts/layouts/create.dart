import 'package:blockchain_utils/utils/utils.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/instructions/name_service/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Create an empty name record layout.
class NameServiceCreateLayout extends NameServiceProgramLayout {
  /// Number of lamports to fund the name record with
  final BigInt lamports;

  /// SHA256 of the (HASH_PREFIX + Name) of the record to create, hashing
  /// is done off-chain
  final List<int> hashedName;

  /// Number of bytes of memory to allocate in addition to the
  /// [NameRecordHeader]
  final int space;

  /// Constructs a NameServiceCreateLayout instance.
  NameServiceCreateLayout({
    required this.lamports,
    required List<int> hashedName,
    required this.space,
  }) : hashedName = BytesUtils.toBytes(hashedName, unmodifiable: true);

  /// Creates a NameServiceCreateLayout instance from buffer data.
  factory NameServiceCreateLayout.fromBuffer(List<int> data) {
    Map<String, dynamic> decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: data,
      instruction: NameServiceProgramInstruction.create.insturction,
    );
    decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: data,
      instruction: NameServiceProgramInstruction.create.insturction,
    );
    return NameServiceCreateLayout(
      lamports: decode["lamports"],
      hashedName: decode["hashedName"],
      space: decode["space"],
    );
  }

  /// Generates the layout structure.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.vecU8(property: "hashedName"),
    LayoutConst.u64(property: "lamports"),
    LayoutConst.u32(property: "space"),
  ]);

  /// The layout structure.
  @override
  StructLayout get layout => _layout;

  /// The instruction associated with the layout.
  @override
  NameServiceProgramInstruction get instruction =>
      NameServiceProgramInstruction.create;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {
      "hashedName": hashedName,
      "lamports": lamports,
      "space": space,
    };
  }
}
