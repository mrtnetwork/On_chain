import 'package:on_chain/tron/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/models/contract/balance/transaction_balance_trace_operation.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class TransactionBalanceTrace extends TronProtocolBufferImpl {
  /// Create a new [TransactionBalanceTrace] instance by parsing a JSON map.
  factory TransactionBalanceTrace.fromJson(Map<String, dynamic> json) {
    return TransactionBalanceTrace(
      transactionIdentifier:
          BytesUtils.tryFromHexString(json["transaction_identifier"]),
      operation: (json["operation"] as List<dynamic>?)
          ?.map((op) => TransactionBalanceTraceOperation.fromJson(op))
          .toList(),
      type: json["type"],
      status: json["status"],
    );
  }

  /// Create a new [TransactionBalanceTrace] instance with specified parameters.
  TransactionBalanceTrace(
      {List<int>? transactionIdentifier,
      List<TransactionBalanceTraceOperation>? operation,
      this.type,
      this.status})
      : transactionIdentifier =
            BytesUtils.tryToBytes(transactionIdentifier, unmodifiable: true),
        operation = operation == null
            ? null
            : List<TransactionBalanceTraceOperation>.unmodifiable(operation);
  final List<int>? transactionIdentifier;
  final List<TransactionBalanceTraceOperation>? operation;
  final String? type;
  final String? status;

  @override
  List<int> get fieldIds => [1, 2, 3, 4];

  @override
  List get values => [transactionIdentifier, operation, type, status];

  /// Convert the [TransactionBalanceTrace] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "transaction_identifier":
          BytesUtils.tryToHexString(transactionIdentifier),
      "operation": operation?.map((op) => op.toJson()).toList(),
      "type": type,
      "status": status,
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [TransactionBalanceTrace] object to its string representation.
  @override
  String toString() {
    return "TransactionBalanceTrace{${toJson()}}";
  }
}
