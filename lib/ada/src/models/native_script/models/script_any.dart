import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/utils/compare/compare.dart';
import 'package:blockchain_utils/utils/compare/hash_code.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/native_script/models/native_script.dart';
import 'package:on_chain/ada/src/models/native_script/models/native_script_type.dart';
import 'package:on_chain/ada/src/models/native_script/utils/native_script_utils.dart';

/// Represents a native script that requires any of the provided scripts to be satisfied.
class NativeScriptScriptAny extends NativeScript {
  /// The list of native scripts.
  final List<NativeScript> nativeScripts;

  /// Constructs a [NativeScriptScriptAny].
  NativeScriptScriptAny(List<NativeScript> nativeScripts)
      : nativeScripts = List<NativeScript>.unmodifiable(nativeScripts);

  /// Deserializes a [NativeScriptScriptAny] from CBOR.
  factory NativeScriptScriptAny.deserialize(CborListValue cbor) {
    NativeScriptUtils.validateCborTypeObject(
        cbor.elementAt<CborObject>(0), NativeScriptType.scriptAny);
    return NativeScriptScriptAny(cbor
        .elementAt<CborListValue>(1)
        .valueAsListOf<CborListValue>()
        .map((e) => NativeScript.deserialize(e))
        .toList());
  }
  NativeScriptScriptAny copyWith({List<NativeScript>? nativeScripts}) {
    return NativeScriptScriptAny(nativeScripts ?? this.nativeScripts);
  }

  factory NativeScriptScriptAny.fromJson(Map<String, dynamic> json) {
    final correctJson = json[NativeScriptType.scriptAny.name] ?? json;
    return NativeScriptScriptAny((correctJson['native_scripts'] as List)
        .map((e) => NativeScript.fromJson(e))
        .toList());
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      CborListValue.definite(nativeScripts.map((e) => e.toCbor()).toList())
    ]);
  }

  @override
  NativeScriptType get type => NativeScriptType.scriptAny;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        'native_scripts': nativeScripts.map((e) => e.toJson()).toList(),
      }
    };
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! NativeScriptScriptAny) return false;
    return CompareUtils.iterableIsEqual(nativeScripts, other.nativeScripts);
  }

  @override
  int get hashCode => HashCodeGenerator.generateHashCode([type, nativeScripts]);
}
