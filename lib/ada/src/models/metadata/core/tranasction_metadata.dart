import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/metadata/types/types.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/metadata/utils/metadata_utils.dart';
import 'config.dart';
import 'metadata_json_schame.dart';
import 'transaction_metadata_types.dart';

/// Abstract class representing transaction metadata.
abstract class TransactionMetadata<T>
    with ADASerialization
    implements Comparable<TransactionMetadata> {
  /// Constructs a TransactionMetadata.
  const TransactionMetadata();

  /// The type of the transaction metadata.
  abstract final TransactionMetadataType type;

  /// Constructs a TransactionMetadata from JSON.
  factory TransactionMetadata.fromJsonSchema({
    required dynamic json,
    required MetadataJsonSchema jsonSchema,
  }) {
    return TransactionMetadataUtils.parseTransactionMetadata(json, jsonSchema)
        as TransactionMetadata<T>;
  }

  /// Constructs a TransactionMetadata from CBOR.
  factory TransactionMetadata.deserialize(CborObject obj) {
    return TransactionMetadataUtils.deserialize(obj) as TransactionMetadata<T>;
  }

  /// Constructs a TransactionMetadata from CBOR bytes.
  factory TransactionMetadata.fromCborBytes(List<int> cborBytes) {
    return TransactionMetadataUtils.deserialize(CborObject.fromCbor(cborBytes))
        as TransactionMetadata<T>;
  }

  factory TransactionMetadata.fromJson(Map<String, dynamic> json) {
    TransactionMetadataType type;
    try {
      type = TransactionMetadataType.fromName(json.keys.first);
    } on StateError {
      throw MessageException("Invalid metadata json.", details: {"json": json});
    }
    final TransactionMetadata metadata;
    switch (type) {
      case TransactionMetadataType.metadataBytes:
        metadata = TransactionMetadataBytes.fromJson(json);
        break;
      case TransactionMetadataType.metadataInt:
        metadata = TransactionMetadataInt.fromJson(json);
        break;
      case TransactionMetadataType.metadataList:
        metadata = TransactionMetadataList.fromJson(json);
        break;
      case TransactionMetadataType.metadataMap:
        metadata = TransactionMetadataMap.fromJson(json);
        break;
      default:
        metadata = TransactionMetadataText.fromJson(json);
        break;
    }
    return metadata as TransactionMetadata<T>;
  }

  /// Converts the transaction metadata to JSON.
  @override
  Map<String, dynamic> toJson();

  dynamic toJsonSchema(
      {MetadataSchemaConfig config = const MetadataSchemaConfig(
          jsonSchema: MetadataJsonSchema.noConversions)});

  /// The value of the transaction metadata.
  abstract final T value;

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  int compareTo(TransactionMetadata other) {
    return runtimeType.toString().compareTo(other.runtimeType.toString());
  }
}
