import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/transaction/transaction/auxiliary_data.dart';
import 'package:on_chain/ada/src/models/transaction/transaction/body.dart';
import 'package:on_chain/ada/src/models/transaction/witnesses/transaction_witness_set.dart';

class ADATransaction with ADASerialization {
  final TransactionBody body;
  final TransactionWitnessSet witnessSet;
  final bool isValid;
  final AuxiliaryData? data;

  const ADATransaction(
      {required this.body,
      required this.witnessSet,
      this.isValid = true,
      this.data});
  factory ADATransaction.fromCborBytes(List<int> bytes) {
    final CborListValue decode = ADASerialization.desrialize(bytes);
    return ADATransaction.deserialize(decode);
  }
  factory ADATransaction.deserialize(CborListValue cbor) {
    return ADATransaction(
        body: TransactionBody.deserialize(cbor.getIndex(0)),
        witnessSet: TransactionWitnessSet.deserialize(cbor.getIndex(1)),
        isValid: cbor.getIndex(2),
        data: cbor.getIndex<CborObject?>(3)?.to<AuxiliaryData, CborObject>(
            (e) => AuxiliaryData.deserialize(e)));
  }
  factory ADATransaction.fromJson(Map<String, dynamic> json) {
    return ADATransaction(
        body: TransactionBody.fromJson(json["body"]),
        witnessSet: TransactionWitnessSet.fromJson(json["witness_set"]),
        data: json["auxiliary_data"] == null
            ? null
            : AuxiliaryData.fromJson(json["auxiliary_data"]),
        isValid: json["is_valid"]);
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
    return CborListValue.fixedLength([
      body.toCbor(),
      witnessSet.toCbor(),
      CborBoleanValue(isValid),
      data?.toCbor(),
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "body": body.toJson(),
      "witness_set": witnessSet.toJson(),
      "is_valid": isValid,
      "auxiliary_data": data?.toJson()
    };
  }

  int get size => serialize().length;
}
