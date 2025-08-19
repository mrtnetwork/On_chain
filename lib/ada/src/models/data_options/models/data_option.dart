import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/data_options/models/data_hash.dart';
import 'package:on_chain/ada/src/models/data_options/models/data_option_type.dart';
import 'package:on_chain/ada/src/models/data_options/models/data.dart';

/// Represents a data option in a transaction with serialization support.
abstract class DataOption with ADASerialization {
  /// Constructs a DataOption object.
  const DataOption();

  /// The type of the data option.
  abstract final TransactionDataOptionType type;

  /// Deserializes a DataOption object from its CBOR representation.
  factory DataOption.deserialize(CborObject cbor) {
    if (cbor.hasType<CborBytesValue>()) {
      return DataOptionDataHash.deserialize(cbor);
    }
    final type = TransactionDataOptionType.deserialize(
        cbor.as<CborListValue>("DataOption").elementAt<CborIntValue>(0));
    if (type == TransactionDataOptionType.dataHash) {
      return DataOptionDataHash.deserialize(cbor);
    }
    return DataOptionData.deserialize(cbor.as<CborListValue>());
  }
  factory DataOption.fromJson(Map<String, dynamic> json) {
    final type = TransactionDataOptionType.fromName(json.keys.firstOrNull);
    switch (type) {
      case TransactionDataOptionType.dataHash:
        return DataOptionDataHash.fromJson(json);
      case TransactionDataOptionType.data:
        return DataOptionData.fromJson(json);
      default:
        throw throw ADAPluginException('Invalid TransactionDataOptionType.',
            details: {'name': type.name});
    }
  }

  @override
  CborObject toCbor([bool legacy = true]);

  @override
  Map<String, dynamic> toJson();
}
