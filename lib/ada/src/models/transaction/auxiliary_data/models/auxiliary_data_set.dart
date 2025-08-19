import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:on_chain/ada/src/models/transaction/auxiliary_data/models/auxiliary_data.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

class AuxiliaryDataSet with ADASerialization {
  final Map<int, AuxiliaryData> auxiliaryDataSet;
  AuxiliaryDataSet({Map<int, AuxiliaryData> auxiliaryDataSet = const {}})
      : auxiliaryDataSet = auxiliaryDataSet.immutable;
  factory AuxiliaryDataSet.deserialize(CborMapValue cbor) {
    final map = cbor.valueAsMap<CborIntValue, CborObject>();
    return AuxiliaryDataSet(auxiliaryDataSet: {
      for (final i in map.entries)
        i.key.value: AuxiliaryData.deserialize(i.value)
    });
  }
  factory AuxiliaryDataSet.fromJson(Map<String, dynamic> json) {
    return AuxiliaryDataSet(auxiliaryDataSet: {
      for (final i in (json["auxiliary_data_set"] as Map).entries)
        i.key: AuxiliaryData.fromJson(i.value)
    });
  }

  @override
  CborObject toCbor() {
    return CborMapValue.definite({
      for (final i in auxiliaryDataSet.entries)
        CborUnsignedValue.u32(i.key): i.value.toCbor()
    });
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "auxiliary_data_set":
          auxiliaryDataSet.map((k, v) => MapEntry(k, v.toJson()))
    };
  }
}
