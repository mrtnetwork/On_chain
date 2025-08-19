import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:on_chain/ada/src/models/transaction/witnesses/models/transaction_witness_set.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

class TransactionWitnessSets with ADASerialization {
  final List<TransactionWitnessSet> transactions;
  TransactionWitnessSets({List<TransactionWitnessSet> transactions = const []})
      : transactions = transactions.immutable;
  factory TransactionWitnessSets.deserialize(CborListValue cbor) {
    return TransactionWitnessSets(
        transactions: cbor
            .valueAsListOf<CborMapValue>()
            .map((e) => TransactionWitnessSet.deserialize(e))
            .toList());
  }
  factory TransactionWitnessSets.fromJson(Map<String, dynamic> json) {
    return TransactionWitnessSets(
        transactions: (json["witnesses"] as List)
            .map((e) => TransactionWitnessSet.fromJson(e))
            .toList());
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite(transactions.map((e) => e.toCbor()).toList());
  }

  @override
  Map<String, dynamic> toJson() {
    return {"witnesses": transactions.map((e) => e.toJson()).toList()};
  }
}
