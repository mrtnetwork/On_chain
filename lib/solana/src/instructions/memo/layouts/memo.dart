import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/memo/instruction/instructions.dart';

/// Represents the layout for a memo in a Solana transaction.
class MemoLayout extends ProgramLayout {
  /// The raw memo bytes.
  ///
  /// Use [MemoLayout.fromString] to build one from text and [memo] to read it
  /// back as a best-effort UTF-8 string.
  final BuBytes memoBytes;

  /// Constructs a MemoLayout instance from raw bytes.
  MemoLayout({required List<int> memoBytes})
    : memoBytes = memoBytes.asImmutableBytes;

  /// Constructs a MemoLayout instance from a UTF-8 string.
  factory MemoLayout.fromString(String memo) =>
      MemoLayout(memoBytes: StringUtils.encode(memo));

  /// Constructs a MemoLayout instance from a buffer, preserving the bytes as-is.
  factory MemoLayout.fromBuffer(List<int> data) => MemoLayout(memoBytes: data);

  /// The memo decoded as a best-effort UTF-8 string.
  ///
  /// Lossy for non-UTF-8 payloads; use [memoBytes]/[toBytes] when exact bytes
  /// matter.
  String get memo => StringUtils.decode(
    memoBytes,
    encoding: StringEncoding.utf8,
    allowInvalidOrMalformed: true,
  );

  @override
  StructLayout get layout => throw BuError(DefaultErrorType.unsupported, 'layout is not available for this instruction.',
  );

  @override
  MemoProgramInstruction get instruction => MemoProgramInstruction.memo;

  @override
  Map<String, dynamic> serialize() => {};

  @override
  BuBytes toBytes() => memoBytes;

  @override
  Map<String, dynamic> toJson() => {
    'memo':
        StringUtils.tryDecode(memoBytes) ??
        BytesUtils.toHexString(memoBytes, prefix: '0x'),
  };
}
