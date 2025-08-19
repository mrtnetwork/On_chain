import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/metadata/utils/metadata_utils.dart';
import 'bytes.dart';
import 'config.dart';
import 'int.dart';
import 'list.dart';
import 'map.dart';
import 'metadata_json_schame.dart';
import 'text.dart';
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
    TransactionMetadataType type = TransactionMetadataType.fromName(
        json.keys.firstWhereNullable((e) => e != "serialization_config"));
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
  CborObject toCbor({bool sort = false});

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  int compareTo(TransactionMetadata other) {
    return runtimeType.toString().compareTo(other.runtimeType.toString());
  }
}
