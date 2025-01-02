import 'package:blockchain_utils/layout/layout.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/memo/instruction/instructions.dart';

/// Represents the layout for a memo in a Solana transaction.
class MemoLayout extends ProgramLayout {
  /// The memo string.
  final String memo;

  /// Constructs a MemoLayout instance.
  const MemoLayout({required this.memo});

  /// Constructs a MemoLayout instance from a buffer.
  factory MemoLayout.fromBuffer(List<int> data) {
    return MemoLayout(
        memo: StringUtils.decode(data,
            type: StringEncoding.utf8, allowInvalidOrMalformed: true));
  }

  @override
  StructLayout get layout => throw UnimplementedError();

  @override
  MemoProgramInstruction get instruction => MemoProgramInstruction.memo;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }

  @override
  List<int> toBytes() {
    return StringUtils.toBytes(memo);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'memo': memo};
  }
}
