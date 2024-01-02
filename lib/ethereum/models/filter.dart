import 'package:on_chain/ethereum/models/block_tag.dart';

/// Represents a filter configuration for Ethereum event logs.
class Filter {
  /// The starting block number or tag for the filter.
  final BlockTagOrNumber? fromBlock;

  /// The ending block number or tag for the filter.
  final BlockTagOrNumber? toBlock;

  /// The address to filter events for.
  final String? address;

  /// The block hash to filter events for.
  final String? blockHash;

  /// The list of topics to filter events for.
  final List<List<String>?> topics;

  /// Creates a new instance of the [Filter] class.
  const Filter({
    this.fromBlock,
    this.toBlock,
    this.address,
    this.blockHash,
    this.topics = const [],
  });
}
