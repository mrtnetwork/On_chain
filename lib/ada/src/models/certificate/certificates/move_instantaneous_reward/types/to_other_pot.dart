import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/move_instantaneous_reward/types/mir.dart';

/// Represents a Move Instance Reward to be allocated to another pot, with serialization support.
class ToOtherPot extends MIR {
  /// The value of the MIR.
  final BigInt value;

  /// Constructs a ToOtherPot MIR object with the specified value.
  const ToOtherPot(this.value);

  /// Deserializes a ToOtherPot MIR object from its CBOR representation.
  factory ToOtherPot.deserialize(CborNumeric cbor) {
    return ToOtherPot(cbor.toBigInt());
  }
  ToOtherPot copyWith({BigInt? value}) {
    return ToOtherPot(value ?? this.value);
  }

  @override
  CborObject toCbor() {
    return CborUnsignedValue.u64(value);
  }

  @override
  String toJson() {
    return value.toString();
  }
}
