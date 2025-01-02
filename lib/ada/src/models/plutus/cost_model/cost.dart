import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

/// Represents a cost model.
class CostModel with ADASerialization {
  /// The list of values in the cost model.
  final List<BigInt> values;

  /// Constructs a [CostModel] instance.
  CostModel(List<BigInt> values) : values = List<BigInt>.unmodifiable(values);

  /// Deserializes a [CostModel] instance from CBOR object.
  factory CostModel.deserialize(CborObject cbor) {
    if (cbor is CborBytesValue) {
      final viewDecoding = CborObject.fromCbor(cbor.value)
          .cast<CborListValue<CborObject>>(
              'Invalid CostModel view encoding cbor bytes.');
      return CostModel(viewDecoding.value.map((e) => e.getInteger()).toList());
    }
    return CostModel(cbor
        .cast<CborListValue<CborObject>>()
        .value
        .map((e) => e.getInteger())
        .toList());
  }
  factory CostModel.fromJson(List<String> json) {
    return CostModel(json.map((e) => BigInt.parse(e)).toList());
  }

  @override
  CborObject toCbor([bool indefinite = false]) {
    if (indefinite) {
      return CborBytesValue(CborListValue<CborSignedValue>.dynamicLength(
              values.map((e) => CborSignedValue.i64(e)).toList())
          .encode());
    }
    return CborListValue<CborSignedValue>.fixedLength(
        values.map((e) => CborSignedValue.i64(e)).toList());
  }

  @override
  List<String> toJson() {
    return values.map((e) => e.toString()).toList();
  }
}
