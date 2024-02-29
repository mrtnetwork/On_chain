/// Represents block tag used in Ethereum JSON-RPC requests.
class BlockTag {
  final String value;

  const BlockTag._(this.value);

  /// for the earliest/genesis block.
  static const BlockTag earliest = BlockTag._('earliest');

  /// for the latest mined block.
  static const BlockTag latest = BlockTag._('latest');

  ///  for the latest safe head block.
  static const BlockTag pending = BlockTag._('pending');

  /// for the latest finalized block/
  static const BlockTag safe = BlockTag._('safe');

  /// for the pending state/transactions.
  static const BlockTag finalized = BlockTag._('finalized');
}

/// Represents a block number or tag in Ethereum JSON-RPC requests.
class BlockTagOrNumber {
  /// an integer block number
  const BlockTagOrNumber.fromBlockNumber(int this._blockNumber) : _tag = null;

  /// from tags
  const BlockTagOrNumber.fromTag(BlockTag this._tag) : _blockNumber = null;

  final int? _blockNumber;
  final BlockTag? _tag;

  /// for the earliest/genesis block.
  static const BlockTagOrNumber earliest =
      BlockTagOrNumber.fromTag(BlockTag.earliest);

  /// for the latest mined block.
  static const BlockTagOrNumber latest =
      BlockTagOrNumber.fromTag(BlockTag.latest);

  /// Represents the 'pending' block number or tag.
  static const BlockTagOrNumber pending =
      BlockTagOrNumber.fromTag(BlockTag.pending);

  /// for the latest safe head block.
  static const BlockTagOrNumber safe = BlockTagOrNumber.fromTag(BlockTag.safe);

  /// for the latest finalized block.
  static const BlockTagOrNumber finalized =
      BlockTagOrNumber.fromTag(BlockTag.finalized);

  String? get _toRadix16Number {
    if (_blockNumber != null) return "0x${_blockNumber!.toRadixString(16)}";
    return null;
  }

  /// Converts the block number or tag to its JSON representation.
  String toJson() {
    return _tag?.value ?? _toRadix16Number!;
  }
}
