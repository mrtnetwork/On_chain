import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/instructions/name_service/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.vecU8("hashedName"),
    LayoutUtils.u64("lamports"),
    LayoutUtils.u32("space"),
  ]);

  /// The layout structure.
  @override
  Structure get layout => _layout;

  /// The instruction associated with the layout.
  @override
  int get instruction => NameServiceProgramInstruction.create.insturction;

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
