import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/metadata/models/tranasction_metadata.dart';

/// Represents general transaction metadata.
class GeneralTransactionMetadata with ADASerialization {
  /// The metadata associated with each transaction index.
  final Map<BigInt, TransactionMetadata> metadata;

  /// Constructs a GeneralTransactionMetadata object.
  GeneralTransactionMetadata(
      {required Map<BigInt, TransactionMetadata> metadata})
      : metadata = Map<BigInt, TransactionMetadata>.unmodifiable(metadata);

  /// Deserializes a GeneralTransactionMetadata object from CBOR.
  factory GeneralTransactionMetadata.deserialize(CborMapValue cbor) {
    final map =
        cbor.valueAsMap<CborNumeric, CborObject>("GeneralTransactionMetadata");
    final metadata = {
      for (final entry in map.entries)
        entry.key.toBigInt(): TransactionMetadata.deserialize(entry.value)
    };
    return GeneralTransactionMetadata(metadata: metadata);
  }

  factory GeneralTransactionMetadata.fromJson(Map<String, dynamic> json) {
    return GeneralTransactionMetadata(metadata: {
      for (final i in json.entries)
        BigintUtils.parse(i.key): TransactionMetadata.fromJson(i.value)
    });
  }
  GeneralTransactionMetadata copyWith(
      {Map<BigInt, TransactionMetadata>? metadata}) {
    return GeneralTransactionMetadata(metadata: metadata ?? this.metadata);
  }

  /// Converts the metadata to CBOR.
  @override
  CborObject toCbor() {
    return CborMapValue.definite({
      for (final entry in metadata.entries)
        CborUnsignedValue.u64(entry.key): entry.value.toCbor()
    });
  }

  /// Converts the metadata to JSON.
  @override
  Map<String, dynamic> toJson() {
    return {
      for (final entry in metadata.entries)
        entry.key.toString(): entry.value.toJson()
    };
  }
}
