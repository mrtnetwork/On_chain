import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/transaction/auxiliary_data/models/auxiliary_data.dart';
import 'package:on_chain/ada/src/models/transaction/transaction/models/body.dart';
import 'package:on_chain/ada/src/models/transaction/witnesses/models/transaction_witness_set.dart';

class ADATransaction with InternalCborSerialization {
  final TransactionBody body;
  final TransactionWitnessSet witnessSet;
  final bool isValid;
  final AuxiliaryData? data;

  const ADATransaction({
    required this.body,
    required this.witnessSet,
    this.isValid = true,
    this.data,
  });
  factory ADATransaction.fromCborBytes(List<int> bytes) {
    final CborListValue decode = InternalCborSerialization.desrialize(bytes);
    return ADATransaction.deserialize(decode);
  }
  factory ADATransaction.deserialize(CborListValue cbor) {
    return ADATransaction(
      body: TransactionBody.deserialize(cbor.objectAt<CborMapValue>(0)),
      witnessSet: TransactionWitnessSet.deserialize(
        cbor.objectAt<CborMapValue>(1),
      ),
      isValid: cbor.objectAt<CborBoleanValue>(2).value,
      data: cbor.maybeObjectAt<AuxiliaryData, CborObject>(
        3,
        (e) => AuxiliaryData.deserialize(e),
      ),
    );
  }
  factory ADATransaction.fromJson(Map<String, dynamic> json) {
    return ADATransaction(
      body: TransactionBody.fromJson(json['body']),
      witnessSet: TransactionWitnessSet.fromJson(json['witness_set']),
      data:
          json['auxiliary_data'] == null
              ? null
              : AuxiliaryData.fromJson(json['auxiliary_data']),
      isValid: json['is_valid'],
    );
  }

  ADATransaction copyWith({
    TransactionBody? body,
    TransactionWitnessSet? witnessSet,
    bool? isValid,
    AuxiliaryData? data,
  }) {
    return ADATransaction(
      body: body ?? this.body,
      witnessSet: witnessSet ?? this.witnessSet,
      isValid: isValid ?? this.isValid,
      data: data ?? this.data,
    );
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      body.toCbor(),
      witnessSet.toCbor(),
      CborBoleanValue(isValid),
      data?.toCbor() ?? const CborNullValue(),
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'body': body.toJson(),
      'witness_set': witnessSet.toJson(),
      'is_valid': isValid,
      'auxiliary_data': data?.toJson(),
    };
  }

  int get size => serialize().length;
}
