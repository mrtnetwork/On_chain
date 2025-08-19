import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/native_script/models/native_script_type.dart';
import 'package:on_chain/ada/src/models/native_script/utils/native_script_utils.dart';

import 'native_script.dart';

/// Represents a native script that enforces a timelock expiry at a specific slot.
class NativeScriptTimelockExpiry extends NativeScript {
  /// The slot at which the timelock expires.
  final BigInt slot;

  /// Constructs a [NativeScriptTimelockExpiry].
  const NativeScriptTimelockExpiry(this.slot);

  /// Deserializes a [NativeScriptTimelockExpiry] from CBOR.
  factory NativeScriptTimelockExpiry.deserialize(CborListValue cbor) {
    NativeScriptUtils.validateCborTypeObject(
        cbor.elementAt<CborObject>(0), NativeScriptType.timelockExpiry);
    return NativeScriptTimelockExpiry(cbor.elementAsInteger(1));
  }

  factory NativeScriptTimelockExpiry.fromJson(Map<String, dynamic> json) {
    final correctJson = json[NativeScriptType.timelockExpiry.name] ?? json;
    return NativeScriptTimelockExpiry(BigintUtils.parse(correctJson['slot']));
  }
  NativeScriptTimelockExpiry copyWith({BigInt? slot}) {
    return NativeScriptTimelockExpiry(slot ?? this.slot);
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      CborUnsignedValue.u64(slot),
    ]);
  }

  @override
  NativeScriptType get type => NativeScriptType.timelockExpiry;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {'slot': slot}
    };
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! NativeScriptTimelockExpiry) return false;
    return other.slot == slot;
  }

  @override
  int get hashCode => HashCodeGenerator.generateHashCode([slot, type]);
}
