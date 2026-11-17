import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/fil/src/serialization/src/fill.dart';

class FilTokenAmount with FilSerialization {
  final BigInt value;
  const FilTokenAmount(this.value);
  factory FilTokenAmount.zero() => FilTokenAmount(BigInt.zero);
  factory FilTokenAmount.from(int v) => FilTokenAmount(BigInt.from(v));
  @override
  CborObject<Object?> toCbor() {
    if (value == BigInt.zero) {
      return CborBytesValue([]);
    }

    return CborBytesValue([value.isNegative ? 1 : 0, ...value.toBeBytes()]);
  }

  String toJson() => "$value";
}
