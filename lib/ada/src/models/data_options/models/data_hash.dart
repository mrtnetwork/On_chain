import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/data_options/models/data_option.dart';
import 'package:on_chain/ada/src/models/data_options/models/data_option_type.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

/// Represents a data option with a data hash in a transaction with serialization support.
class DataOptionDataHash extends DataOption {
  /// The data hash associated with this data option.
  final DataHash dataHash;

  /// Constructs a DataOptionDataHash object with the given data hash.
  const DataOptionDataHash(this.dataHash);

  /// Constructs a DataOptionDataHash object from bytes.
  factory DataOptionDataHash.fromBytes(List<int> bytes) {
    return DataOptionDataHash(DataHash(bytes));
  }

  /// Deserializes a DataOptionDataHash object from its CBOR representation.
  factory DataOptionDataHash.deserialize(CborObject cbor) {
    if (cbor.hasType<CborBytesValue>()) {
      return DataOptionDataHash(
          DataHash(cbor.as<CborBytesValue>("DataHash").value));
    }
    final cborList = cbor.as<CborListValue>("DataOption");
    TransactionDataOptionType.deserialize(cborList.elementAt<CborIntValue>(0),
        validate: TransactionDataOptionType.dataHash);
    return DataOptionDataHash(DataHash(
        cborList.elementAt<CborBytesValue>(1, name: "DataHash").value));
  }
  factory DataOptionDataHash.fromJson(Map<String, dynamic> json) {
    return DataOptionDataHash(
        DataHash.fromHex(json[TransactionDataOptionType.dataHash.name]));
  }

  @override
  CborObject toCbor([bool legacy = true]) {
    if (legacy) return dataHash.toCbor();
    return CborListValue.definite([type.toCbor(), dataHash.toCbor()]);
  }

  @override
  TransactionDataOptionType get type => TransactionDataOptionType.dataHash;

  @override
  Map<String, dynamic> toJson() {
    return {type.name: dataHash.toJson()};
  }
}
