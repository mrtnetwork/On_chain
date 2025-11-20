import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/data_options/models/data_option_type.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_data/models/plutus_data.dart';
import 'data_option.dart';

/// Represents a data option with Plutus data in a transaction with serialization support.
class DataOptionData extends DataOption {
  static const List<int> _plutusDataOptionTag = [24];

  /// The Plutus data associated with this data option.
  final PlutusData plutusData;

  /// Constructs a DataOptionData object with the given Plutus data.
  const DataOptionData(this.plutusData);

  /// Deserializes a DataOptionData object from its CBOR representation.
  factory DataOptionData.deserialize(CborListValue cbor) {
    TransactionDataOptionType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: TransactionDataOptionType.data);
    final CborTagValue cborTag = cbor.elementAt<CborTagValue>(1);
    if (!BytesUtils.bytesEqual(cborTag.tags, _plutusDataOptionTag)) {
      throw ADAPluginException('Invalid date option tag.',
          details: {'Tag': cborTag.tags, 'expected': _plutusDataOptionTag});
    }
    final List<int> plutusBytes =
        cborTag.valueAs<CborBytesValue>('PlutusData').value;
    return DataOptionData(PlutusData.fromCborBytes(plutusBytes));
  }
  factory DataOptionData.fromJson(Map<String, dynamic> json) {
    return DataOptionData(
        PlutusData.fromJson(json[TransactionDataOptionType.data.name]));
  }

  @override
  Map<String, dynamic> toJson() {
    return {type.name: plutusData.toJson()};
  }

  @override
  CborObject toCbor([bool legacy = true]) {
    return CborListValue.definite([
      type.toCbor(),
      CborTagValue(CborBytesValue(plutusData.serialize()), _plutusDataOptionTag)
    ]);
  }

  @override
  TransactionDataOptionType get type => TransactionDataOptionType.data;
}
