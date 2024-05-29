import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/metadata/core/config.dart';
import 'package:on_chain/ada/src/models/metadata/core/metadata_json_schame.dart';
import 'package:on_chain/ada/src/models/metadata/core/tranasction_metadata.dart';
import 'package:on_chain/ada/src/models/metadata/core/transaction_metadata_types.dart';
import 'package:on_chain/ada/src/models/metadata/types/bytes.dart';
import 'package:on_chain/ada/src/models/metadata/types/int.dart';
import 'package:on_chain/ada/src/models/metadata/types/list.dart';
import 'package:on_chain/ada/src/models/metadata/types/map.dart';
import 'package:on_chain/ada/src/models/metadata/types/text.dart';

/// Utility class for transaction metadata operations.
class TransactionMetadataUtils {
  /// Tag for auxiliary data CBOR.
  static List<int> auxiliaryDataCborTag = [259];

  /// Validates auxiliary data CBOR.
  static void validateAuxiliaryDataCbor(CborObject cbor) {
    if (cbor is! CborMapValue &&
        cbor is! CborListValue &&
        cbor is! CborTagValue) {
      throw MessageException("Invalid AuxiliaryData cbor object type.",
          details: {
            "Type": cbor.runtimeType,
            "Excepted": "$CborMapValue, $CborListValue or $CborTagValue"
          });
    }
    if (cbor is CborTagValue) {
      if (!bytesEqual(cbor.tags, auxiliaryDataCborTag)) {
        throw MessageException("Invalid AuxiliaryData cbor tag.",
            details: {"Exepted": auxiliaryDataCborTag, "Tag": cbor.tags});
      }
    }
  }

  /// Parses transaction metadata based on JSON schema.
  static TransactionMetadata parseTransactionMetadata(
      dynamic value, MetadataJsonSchema jsonSchema) {
    _validateType(value);
    switch (jsonSchema) {
      case MetadataJsonSchema.basicConversions:
      case MetadataJsonSchema.noConversions:
        if (value is int || value is BigInt) {
          return _encodeNumbers(value);
        } else if (value is String) {
          return _encodeString(value, jsonSchema);
        } else if (value is List) {
          return _encodeArray(value, jsonSchema);
        }
        return _encodeMap(value, jsonSchema);
      default:
        return _parseDetailed(value, jsonSchema);
    }
  }

  static TransactionMetadata _parseDetailed(
      dynamic value, MetadataJsonSchema jsonSchema) {
    if (value is! Map<String, dynamic> || value.length != 1) {
      throw const MessageException(
          "DetailedSchema requires types to be tagged objects");
    }
    final entry = value.entries.first;
    final String key = entry.key;
    final v = entry.value;
    switch (key) {
      case 'int':
        return _encodeNumbers(v);
      case "string":
        return _encodeString(v, jsonSchema);
      case "bytes":
        final bytes = BytesUtils.tryFromHexString(v);
        if (bytes == null) {
          throw MessageException("invalid hex string.", details: {"Value": v});
        }
        return TransactionMetadataBytes(value: bytes);
      case "list":
        if (v is! List) {
          throw MessageException("key does not match type.",
              details: {"Key": key, "Value": v});
        }
        return _encodeArray(v, jsonSchema);
      case "map":
        if (v is! List) {
          throw const MessageException(
            r"entry format in detailed schema map object not correct. Needs to be of form '{'k': 'key', 'v': 'value'}'",
          );
        }
        final Map<TransactionMetadata, TransactionMetadata> values = {};
        for (final i in v) {
          if (i is! Map) {
            throw const MessageException(
              r"entry format in detailed schema map object not correct. Needs to be of form '{'k': 'key', 'v': 'value'}'",
            );
          }
          if (!i.containsKey("k") || !i.containsKey("v")) {
            throw const MessageException(
              r"entry format in detailed schema map object not correct. Needs to be of form '{'k': 'key', 'v': 'value'}'",
            );
          }
          values.addAll({
            parseTransactionMetadata(i["k"], jsonSchema):
                parseTransactionMetadata(i["v"], jsonSchema)
          });
        }
        return TransactionMetadataMap(value: values);
      default:
        throw MessageException("key is not valid.", details: {"Key": key});
    }
  }

  /// Deserializes transaction metadata.
  static TransactionMetadata deserialize(CborObject obj) {
    TransactionMetadata metadata;
    if (obj is CborBytesValue) {
      metadata = TransactionMetadataBytes.deserialize(obj);
    } else if (obj is CborNumeric) {
      metadata = TransactionMetadataInt.deserialize(obj);
    } else if (obj is CborStringValue) {
      metadata = TransactionMetadataText.deserialize(obj);
    } else if (obj is CborMapValue) {
      metadata = TransactionMetadataMap.deserialize(obj);
    } else if (obj is CborListValue) {
      metadata = TransactionMetadataList.deserialize(obj);
    } else {
      throw MessageException("Invalid metadata type.",
          details: {"Type": obj.runtimeType});
    }
    return metadata;
  }

  static TransactionMetadata _encodeNumbers(dynamic value) {
    if (value is int) return TransactionMetadataInt(value: BigInt.from(value));
    return TransactionMetadataInt(value: value);
  }

  static TransactionMetadata _encodeString(
      dynamic value, MetadataJsonSchema jsonSchema) {
    if (value is! String) {
      throw MessageException("Invalid string format.",
          details: {"Value": "$value", "Type": "${value.runtimeType}"});
    }
    if (jsonSchema == MetadataJsonSchema.basicConversions) {
      final toBytes = BytesUtils.tryFromHexString(value);
      if (toBytes != null) {
        return TransactionMetadataBytes(value: toBytes);
      }
    }
    return TransactionMetadataText(value: value);
  }

  static TransactionMetadata _encodeArray(
      List<dynamic> value, MetadataJsonSchema jsonSchema) {
    return TransactionMetadataList(
        value:
            value.map((e) => parseTransactionMetadata(e, jsonSchema)).toList());
  }

  static TransactionMetadata _encodeMap(
      Map value, MetadataJsonSchema jsonSchema) {
    Map<TransactionMetadata, TransactionMetadata> values = {};
    for (final i in value.entries) {
      TransactionMetadata? key;
      if (jsonSchema == MetadataJsonSchema.basicConversions &&
          !StringUtils.isHexBytes(i.key)) {
        final bigintKey = BigInt.tryParse(i.key.toString());
        if (bigintKey != null) {
          key = TransactionMetadataInt(value: bigintKey);
        }
      }
      key ??= _encodeString(i.key, jsonSchema);
      values.addAll({key: parseTransactionMetadata(i.value, jsonSchema)});
    }
    return TransactionMetadataMap(value: values);
  }

  static void _validateType(dynamic val) {
    if (val != null) {
      if (val is int ||
          val is BigInt ||
          val is String ||
          val is List ||
          val is Map) return;
    }
    if (val != null) {
      throw MessageException("Invalid metadata format. type not allowed.",
          details: {"Value": val, "Type": "${val.runtimeType}"});
    }
    throw const MessageException("null not allowed in metadata");
  }

  static dynamic encodeKey(
      {required TransactionMetadata key,
      required MetadataSchemaConfig config}) {
    switch (key.type) {
      case TransactionMetadataType.metadataText:
        return key.toJsonSchema(config: config);
      case TransactionMetadataType.metadataBytes:
        if (config.jsonSchema != MetadataJsonSchema.noConversions) {
          return key.toJsonSchema(config: config);
        }
        break;
      case TransactionMetadataType.metadataInt:
        if (config.jsonSchema != MetadataJsonSchema.noConversions) {
          return key.toJsonSchema(config: config).toString();
        }
        break;
      case TransactionMetadataType.metadataList:
      case TransactionMetadataType.metadataMap:
        return key.toJsonSchema(config: config);
    }
    throw MessageException(
        "Key type not allowed in JSON under specified schema.",
        details: {"Key": key, "type": key.type});
  }
}
