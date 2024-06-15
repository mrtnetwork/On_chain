import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/native_script/core/native_script.dart';
import 'package:on_chain/ada/src/models/native_script/core/native_script_type.dart';
import 'package:on_chain/ada/src/models/native_script/utils/native_script_utils.dart';

/// Represents a native script that enforces a timelock expiry at a specific slot.
class NativeScriptTimelockExpiry extends NativeScript {
  /// The slot at which the timelock expires.
  final BigInt slot;

  /// Constructs a [NativeScriptTimelockExpiry].
  const NativeScriptTimelockExpiry(this.slot);

  /// Deserializes a [NativeScriptTimelockExpiry] from CBOR.
  factory NativeScriptTimelockExpiry.deserialize(CborListValue cbor) {
    NativeScriptUtils.validateCborTypeObject(
        cbor.getIndex(0), NativeScriptType.timelockExpiry);
    return NativeScriptTimelockExpiry(
      cbor.getIndex<CborObject>(1).getInteger(),
    );
  }

  factory NativeScriptTimelockExpiry.fromJson(Map<String, dynamic> json) {
    return NativeScriptTimelockExpiry(
        BigintUtils.parse(json["slot"] ?? json["timelock_expiry"]["slot"]));
  }
  NativeScriptTimelockExpiry copyWith({BigInt? slot}) {
    return NativeScriptTimelockExpiry(slot ?? this.slot);
  }

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength([
      type.toCbor(),
      CborUnsignedValue.u64(slot),
    ]);
  }

  @override
  NativeScriptType get type => NativeScriptType.timelockExpiry;

  @override
  Map<String, dynamic> toJson() {
    return {
      "timelock_expiry": {"slot": slot},
    };
  }
}
