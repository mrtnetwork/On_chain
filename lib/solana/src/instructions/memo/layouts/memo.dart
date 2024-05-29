import 'package:blockchain_utils/layout/layout.dart';
import 'package:blockchain_utils/string/string.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Represents the layout for a memo in a Solana transaction.
class MemoLayout extends ProgramLayout {
  /// The memo string.
  final String memo;

  /// Constructs a MemoLayout instance.
  const MemoLayout({required this.memo});

  /// Constructs a MemoLayout instance from a buffer.
  factory MemoLayout.fromBuffer(List<int> data) {
    return MemoLayout(
        memo: StringUtils.decode(data, StringEncoding.utf8, true));
  }

  @override
  StructLayout get layout => throw UnimplementedError();

  @override
  int get instruction => throw UnimplementedError();

  @override
  Map<String, dynamic> serialize() {
    return {};
  }

  @override
  List<int> toBytes() {
    return StringUtils.toBytes(memo);
  }
}
