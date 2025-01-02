import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/native_script/core/native_script.dart';
import 'package:on_chain/ada/src/models/native_script/core/native_script_type.dart';
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
        cbor.getIndex(0), NativeScriptType.scriptAny);
    return NativeScriptScriptAny(cbor
        .getIndex<CborListValue>(1)
        .value
        .map((e) => NativeScript.deserialize(e))
        .toList());
  }
  NativeScriptScriptAny copyWith({List<NativeScript>? nativeScripts}) {
    return NativeScriptScriptAny(nativeScripts ?? this.nativeScripts);
  }

  factory NativeScriptScriptAny.fromJson(Map<String, dynamic> json) {
    return NativeScriptScriptAny(((json['native_scripts'] ??
            json['script_any']['native_scripts']) as List)
        .map((e) => NativeScript.fromJson(e))
        .toList());
  }

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength([
      type.toCbor(),
      CborListValue.fixedLength(nativeScripts.map((e) => e.toCbor()).toList())
    ]);
  }

  @override
  NativeScriptType get type => NativeScriptType.scriptAny;

  @override
  Map<String, dynamic> toJson() {
    return {
      'script_any': {
        'native_scripts': nativeScripts.map((e) => e.toJson()).toList(),
      }
    };
  }
}
