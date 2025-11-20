import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

class ExUnits with InternalCborSerialization {
  final BigInt mem;
  final BigInt steps;
  const ExUnits({required this.mem, required this.steps});

  factory ExUnits.deserialize(CborListValue cbor) {
    return ExUnits(
        mem: cbor.elementAsInteger(0), steps: cbor.elementAsInteger(1));
  }
  factory ExUnits.fromJson(Map<String, dynamic> json) {
    return ExUnits(
        mem: BigintUtils.parse(json['mem']),
        steps: BigintUtils.parse(json['steps']));
  }
  ExUnits copyWith({BigInt? mem, BigInt? steps}) {
    return ExUnits(mem: mem ?? this.mem, steps: steps ?? this.steps);
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite(
        [CborUnsignedValue.u64(mem), CborUnsignedValue.u64(steps)]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'mem': mem.toString(), 'steps': steps.toString()};
  }
}
