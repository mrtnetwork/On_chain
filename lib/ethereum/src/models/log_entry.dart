import 'package:on_chain/utils/utils/number_utils.dart';

/// Represents an entry in Ethereum transaction logs.
class LogEntry {
  /// The address of the contract that emitted the log.
  final String address;

  /// The hash of the block where the log was included.
  final String blockHash;

  /// The block number where the log was included.
  final int blockNumber;

  /// The data associated with the log entry.
  final String data;

  /// The index of the log within the block.
  final int logIndex;

  /// Indicates whether the log entry has been removed.
  final bool removed;

  /// The list of topics associated with the log entry.
  final List<String> topics;

  /// The hash of the transaction that triggered the log entry.
  final String transactionHash;

  /// The index of the transaction within the block.
  final int transactionIndex;

  /// Creates a new instance of the [LogEntry] class.
  const LogEntry({
    required this.address,
    required this.blockHash,
    required this.blockNumber,
    required this.data,
    required this.logIndex,
    required this.removed,
    required this.topics,
    required this.transactionHash,
    required this.transactionIndex,
  });

  /// Creates a [LogEntry] instance from a JSON map.
  factory LogEntry.fromJson(Map<String, dynamic> json) {
    return LogEntry(
      address: json['address'],
      blockHash: json['blockHash'],
      blockNumber: PluginIntUtils.hexToInt(json['blockNumber']),
      data: json['data'],
      logIndex: PluginIntUtils.hexToInt(json['logIndex']),
      removed: json['removed'],
      topics: List<String>.from(json['topics'] ?? []),
      transactionHash: json['transactionHash'],
      transactionIndex: PluginIntUtils.hexToInt(json['transactionIndex']),
    );
  }
}
