import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

/// Represents an input in a transaction.
class TransactionInput with ADASerialization {
  final TransactionHash transactionId;
  final int index;

  const TransactionInput._(this.transactionId, this.index);

  /// Constructs a TransactionInput object.
  factory TransactionInput(
      {required TransactionHash transactionId, required int index}) {
    return TransactionInput._(transactionId, index);
  }
  factory TransactionInput.fromJson(Map<String, dynamic> json) {
    return TransactionInput(
        transactionId: TransactionHash.fromHex(json['transaction_id']),
        index: json['index']);
  }

  /// Deserialize a TransactionInput object from a CBOR list.
  factory TransactionInput.deserialize(CborListValue cbor) {
    return TransactionInput._(
      TransactionHash.deserialize(cbor.getIndex(0)),
      cbor.getIndex(1),
    );
  }

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength([
      transactionId.toCbor(),
      CborUnsignedValue.u32(index),
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'transaction_id': transactionId.toJson(), 'index': index};
  }
}
