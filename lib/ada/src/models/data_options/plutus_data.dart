import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/data_options/core/data_option_type.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/core/plutus_data.dart';
import 'core/data_option.dart';

/// Represents a data option with Plutus data in a transaction with serialization support.
class DataOptionData extends DataOption {
  static const List<int> _plutusDataOptionTag = [24];

  /// The Plutus data associated with this data option.
  final PlutusData plutusData;

  /// Constructs a DataOptionData object with the given Plutus data.
  const DataOptionData(this.plutusData);

  /// Deserializes a DataOptionData object from its CBOR representation.
  factory DataOptionData.deserialize(CborListValue cbor) {
    TransactionDataOptionType.deserialize(cbor.getIndex(0),
        validate: TransactionDataOptionType.data);
    final CborTagValue cborTag = cbor.getIndex(1);
    if (!bytesEqual(cborTag.tags, _plutusDataOptionTag)) {
      throw MessageException("Invalid date option tag.",
          details: {"Tag": cborTag.tags, "Excepted": _plutusDataOptionTag});
    }
    final List<int> plutusBytes = cborTag.getValue();
    return DataOptionData(PlutusData.fromCborBytes(plutusBytes));
  }
  factory DataOptionData.fromJson(Map<String, dynamic> json) {
    return DataOptionData(PlutusData.fromJson(json["data"]));
  }

  @override
  Map<String, dynamic> toJson() {
    return {"data": plutusData.toJson()};
  }

  @override
  CborObject toCbor([bool legacy = true]) {
    return CborListValue.fixedLength([
      type.toCbor(),
      CborTagValue(CborBytesValue(plutusData.serialize()), _plutusDataOptionTag)
    ]);
  }

  @override
  TransactionDataOptionType get type => TransactionDataOptionType.data;
}
