import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/numbers/numbers.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/native_script/core/native_script.dart';
import 'package:on_chain/ada/src/models/native_script/core/native_script_type.dart';
import 'package:on_chain/ada/src/models/native_script/utils/native_script_utils.dart';

/// Represents a native script that enforces a timelock starting at a specific slot.
class NativeScriptTimelockStart extends NativeScript {
  /// The slot at which the timelock starts.
  final BigInt slot;

  /// Constructs a [NativeScriptTimelockStart].
  const NativeScriptTimelockStart(this.slot);

  /// Deserializes a [NativeScriptTimelockStart] from CBOR.
  factory NativeScriptTimelockStart.deserialize(CborListValue cbor) {
    NativeScriptUtils.validateCborTypeObject(
        cbor.getIndex(0), NativeScriptType.timelockStart);
    return NativeScriptTimelockStart(
      cbor.getIndex<CborObject>(1).getInteger(),
    );
  }
  factory NativeScriptTimelockStart.fromJson(Map<String, dynamic> json) {
    return NativeScriptTimelockStart(
        BigintUtils.parse(json["slot"] ?? json["timelock_start"]["slot"]));
  }
  NativeScriptTimelockStart copyWith({BigInt? slot}) {
    return NativeScriptTimelockStart(slot ?? this.slot);
  }

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength([
      type.toCbor(),
      CborUnsignedValue.u64(slot),
    ]);
  }

  @override
  NativeScriptType get type => NativeScriptType.timelockStart;

  @override
  Map<String, dynamic> toJson() {
    return {
      "timelock_start": {"slot": slot.toString()},
    };
  }
}
