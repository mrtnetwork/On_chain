import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:on_chain/ada/src/models/transaction/transaction/models/body.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

class TransactionBodies with InternalCborSerialization {
  final List<TransactionBody> transactions;
  TransactionBodies({List<TransactionBody> transactions = const []})
      : transactions = transactions.immutable;
  factory TransactionBodies.deserialize(CborListValue cbor) {
    return TransactionBodies(
        transactions: cbor
            .valueAsListOf<CborMapValue>()
            .map((e) => TransactionBody.deserialize(
                e.asMap<CborIntValue, CborObject>()))
            .toList());
  }
  factory TransactionBodies.fromJson(Map<String, dynamic> json) {
    return TransactionBodies(
        transactions: (json["transactions"] as List)
            .map((e) => TransactionBody.fromJson(e))
            .toList());
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite(transactions.map((e) => e.toCbor()).toList());
  }

  @override
  Map<String, dynamic> toJson() {
    return {"transactions": transactions.map((e) => e.toJson()).toList()};
  }
}
