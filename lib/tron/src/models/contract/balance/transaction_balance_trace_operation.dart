import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

class TransactionBalanceTraceOperation extends TronProtocolBufferImpl {
  /// Create a new [TransactionBalanceTraceOperation] instance by parsing a JSON map.
  factory TransactionBalanceTraceOperation.fromJson(Map<String, dynamic> json) {
    return TransactionBalanceTraceOperation(
      operationIdentifier: BigintUtils.tryParse(json["operation_identifier"]),
      address: json["address"] == null ? null : TronAddress(json["address"]),
      amount: BigintUtils.tryParse(json["amount"]),
    );
  }

  /// Create a new [TransactionBalanceTraceOperation] instance with specified parameters.
  TransactionBalanceTraceOperation(
      {this.operationIdentifier, this.address, this.amount});

  factory TransactionBalanceTraceOperation.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return TransactionBalanceTraceOperation(
        operationIdentifier: decode.getField(1),
        address: decode
            .getResult(2)
            ?.to<TronAddress, List<int>>((e) => TronAddress.fromBytes(e)),
        amount: decode.getField(3));
  }

  final BigInt? operationIdentifier;
  final TronAddress? address;
  final BigInt? amount;

  @override
  List<int> get fieldIds => [1, 2, 3];

  @override
  List get values => [operationIdentifier, address, amount];

  /// Convert the [TransactionBalanceTraceOperation] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "operation_identifier": operationIdentifier?.toString(),
      "address": address?.toString(),
      "amount": amount.toString(),
    }..removeWhere((key, value) => value == null);
  }

  @override
  String toString() {
    return "TransactionBalanceTraceOperation{${toJson()}}";
  }
}
