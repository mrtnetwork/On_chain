import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/utils/compare/hash_code.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

/// Represents an input in a transaction.
class TransactionInput with InternalCborSerialization {
  final TransactionHash transactionId;
  final int index;
  final String txIdHex;

  const TransactionInput._(this.transactionId, this.index, this.txIdHex);

  /// Constructs a TransactionInput object.
  factory TransactionInput(
      {required TransactionHash transactionId, required int index}) {
    return TransactionInput._(transactionId, index, transactionId.toHex());
  }
  factory TransactionInput.fromJson(Map<String, dynamic> json) {
    return TransactionInput(
        transactionId: TransactionHash.fromHex(json['transaction_id']),
        index: json['index']);
  }

  /// Deserialize a TransactionInput object from a CBOR list.
  factory TransactionInput.deserialize(CborListValue cbor) {
    return TransactionInput(
        transactionId:
            TransactionHash.deserialize(cbor.elementAt<CborBytesValue>(0)),
        index: cbor.elementAt<CborIntValue>(1).value);
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      transactionId.toCbor(),
      CborUnsignedValue.u32(index),
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'transaction_id': transactionId.toJson(), 'index': index};
  }

  @override
  operator ==(other) {
    if (other is! TransactionInput) return false;
    return index == other.index && transactionId == other.transactionId;
  }

  @override
  int get hashCode =>
      HashCodeGenerator.generateHashCode([index, transactionId]);
}
