import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/native_script/models/native_script.dart';
import 'package:on_chain/ada/src/models/native_script/models/native_script_type.dart';
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
        cbor.elementAt<CborObject>(0), NativeScriptType.timelockStart);
    return NativeScriptTimelockStart(cbor.elementAsInteger(1));
  }
  factory NativeScriptTimelockStart.fromJson(Map<String, dynamic> json) {
    final correctJson = json[NativeScriptType.timelockStart.name] ?? json;
    return NativeScriptTimelockStart(BigintUtils.parse(correctJson['slot']));
  }
  NativeScriptTimelockStart copyWith({BigInt? slot}) {
    return NativeScriptTimelockStart(slot ?? this.slot);
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      CborUnsignedValue.u64(slot),
    ]);
  }

  @override
  NativeScriptType get type => NativeScriptType.timelockStart;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {'slot': slot.toString()},
    };
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! NativeScriptTimelockStart) return false;
    return other.slot == slot;
  }

  @override
  int get hashCode => HashCodeGenerator.generateHashCode([slot, type]);
}
