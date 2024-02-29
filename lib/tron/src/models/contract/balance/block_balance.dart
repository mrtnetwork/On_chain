import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/models/contract/balance/block_balance_trace_block_identifier.dart';
import 'package:on_chain/tron/src/models/contract/balance/transaction_balance_trace.dart';

class BlockBalanceTrace extends TronProtocolBufferImpl {
  /// Create a new [BlockBalanceTrace] instance by parsing a JSON map.
  factory BlockBalanceTrace.fromJson(Map<String, dynamic> json) {
    return BlockBalanceTrace(
      blockIdentifier: json["block_identifier"] == null
          ? null
          : BlockBalanceTraceBlockIdentifier.fromJson(json["block_identifier"]),
      timestamp:
          json["timestamp"] == null ? null : BigInt.parse(json["timestamp"]),
      transactionBalanceTrace: json["transaction_balance_trace"] == null
          ? null
          : (json["transaction_balance_trace"] as List<dynamic>)
              .map((trace) => TransactionBalanceTrace.fromJson(trace))
              .toList(),
    );
  }

  /// Create a new [BlockBalanceTrace] instance with specified parameters.
  BlockBalanceTrace(
      {this.blockIdentifier,
      this.timestamp,
      List<TransactionBalanceTrace>? transactionBalanceTrace})
      : transactionBalanceTrace = transactionBalanceTrace == null
            ? null
            : List<TransactionBalanceTrace>.unmodifiable(
                transactionBalanceTrace);
  final BlockBalanceTraceBlockIdentifier? blockIdentifier;

  /// timestamp
  final BigInt? timestamp;

  /// List of transaction information with balance changes
  final List<TransactionBalanceTrace>? transactionBalanceTrace;

  @override
  List<int> get fieldIds => [1, 2, 3];

  @override
  List get values => [blockIdentifier, timestamp, transactionBalanceTrace];

  /// Convert the [BlockBalanceTrace] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "block_identifier": blockIdentifier?.toJson(),
      "timestamp": timestamp?.toString(),
      "transaction_balance_trace":
          transactionBalanceTrace?.map((trace) => trace.toJson()).toList(),
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [BlockBalanceTrace] object to its string representation.
  @override
  String toString() {
    return "BlockBalanceTrace{${toJson()}}";
  }
}
