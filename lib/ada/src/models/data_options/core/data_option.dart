import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/data_options/data_option_data_hash.dart';
import 'package:on_chain/ada/src/models/data_options/core/data_option_type.dart';
import 'package:on_chain/ada/src/models/data_options/plutus_data.dart';

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
        cbor.cast<CborListValue>().getIndex(0));
    if (type == TransactionDataOptionType.dataHash) {
      return DataOptionDataHash.deserialize(cbor);
    }
    return DataOptionData.deserialize(cbor.cast());
  }
  factory DataOption.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("data")) {
      return DataOptionData.fromJson(json);
    }
    return DataOptionDataHash.fromJson(json);
  }

  @override
  CborObject toCbor([bool legacy = true]);
}
