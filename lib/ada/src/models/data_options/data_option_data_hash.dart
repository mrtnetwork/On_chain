import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/data_options/core/data_option.dart';
import 'package:on_chain/ada/src/models/data_options/core/data_option_type.dart';
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
      return DataOptionDataHash(DataHash(cbor.cast<CborBytesValue>().value));
    }
    final cborList = cbor.cast<CborListValue>();
    TransactionDataOptionType.deserialize(cborList.getIndex(0),
        validate: TransactionDataOptionType.dataHash);
    return DataOptionDataHash(
        DataHash(cborList.getIndex<CborBytesValue>(1).value));
  }
  factory DataOptionDataHash.fromJson(Map<String, dynamic> json) {
    return DataOptionDataHash(DataHash.fromHex(json['data_hash']));
  }

  @override
  CborObject toCbor([bool legacy = true]) {
    if (legacy) return dataHash.toCbor();
    return CborListValue.fixedLength([type.toCbor(), dataHash.toCbor()]);
  }

  @override
  TransactionDataOptionType get type => TransactionDataOptionType.dataHash;

  @override
  Map<String, dynamic> toJson() {
    return {'data_hash': dataHash.toJson()};
  }
}
