import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/block/models/header/header/header.dart';
import 'package:on_chain/ada/src/models/transaction/auxiliary_data/models/auxiliary_data_set.dart';
import 'package:on_chain/ada/src/models/transaction/transaction/models/transaction_bodies.dart';
import 'package:on_chain/ada/src/models/transaction/witnesses/models/transaction_witnesses_sets.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

class CardanoBlock with InternalCborSerialization {
  final Header header;
  final TransactionBodies transactionBodies;
  final TransactionWitnessSets transactionWitnessSets;
  final AuxiliaryDataSet auxiliaryDataSet;
  final List<int> invalidTransactions;
  factory CardanoBlock.fromJson(Map<String, dynamic> json) {
    return CardanoBlock(
      header: Header.fromJson(json['header']),
      transactionBodies: TransactionBodies.fromJson(json['transaction_bodies']),
      transactionWitnessSets:
          TransactionWitnessSets.fromJson(json['transaction_witness_sets']),
      auxiliaryDataSet: AuxiliaryDataSet.fromJson(json['auxiliary_data_set']),
      invalidTransactions: List<int>.from(json["invalid_transactions"]),
    );
  }

  CardanoBlock(
      {required this.header,
      required this.transactionBodies,
      required this.transactionWitnessSets,
      required this.auxiliaryDataSet,
      required List<int> invalidTransactions})
      : invalidTransactions = invalidTransactions.immutable;
  factory CardanoBlock.deserialize(CborListValue cbor) {
    return CardanoBlock(
      header: Header.deserialize(cbor.elementAt<CborListValue>(0)),
      transactionBodies:
          TransactionBodies.deserialize(cbor.elementAt<CborListValue>(1)),
      transactionWitnessSets:
          TransactionWitnessSets.deserialize(cbor.elementAt<CborListValue>(2)),
      auxiliaryDataSet:
          AuxiliaryDataSet.deserialize(cbor.elementAt<CborMapValue>(3)),
      invalidTransactions: cbor
          .elementAt<CborListValue>(4)
          .valueAsListOf<CborIntValue>()
          .map((e) => e.value)
          .toList(),
    );
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite(toCborObjects());
  }

  List<CborObject> toCborObjects() {
    return [
      header.toCbor(),
      transactionBodies.toCbor(),
      transactionWitnessSets.toCbor(),
      auxiliaryDataSet.toCbor(),
      CborListValue.definite(
          invalidTransactions.map((e) => CborIntValue(e)).toList())
    ];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'header': header.toJson(),
      'transaction_bodies': transactionBodies.toJson(),
      'transaction_witness_sets': transactionWitnessSets.toJson(),
      'auxiliary_data_set': auxiliaryDataSet.toJson(),
      'invalid_transactions': invalidTransactions,
    };
  }
}
