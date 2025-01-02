import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/native_script/core/native_script.dart';
import 'package:on_chain/ada/src/models/native_script/core/native_script_type.dart';
import 'package:on_chain/ada/src/models/native_script/utils/native_script_utils.dart';

/// Represents a native script that requires all provided scripts to be satisfied.
class NativeScriptScriptAll extends NativeScript {
  /// The list of native scripts.
  final List<NativeScript> nativeScripts;

  /// Constructs a [NativeScriptScriptAll].
  NativeScriptScriptAll(List<NativeScript> nativeScripts)
      : nativeScripts = List<NativeScript>.unmodifiable(nativeScripts);

  /// Deserializes a [NativeScriptScriptAll] from CBOR.
  factory NativeScriptScriptAll.deserialize(CborListValue cbor) {
    NativeScriptUtils.validateCborTypeObject(
        cbor.getIndex(0), NativeScriptType.scriptAll);
    return NativeScriptScriptAll(cbor
        .getIndex<CborListValue>(1)
        .value
        .map((e) => NativeScript.deserialize(e))
        .toList());
  }
  factory NativeScriptScriptAll.fromJson(Map<String, dynamic> json) {
    return NativeScriptScriptAll(((json['native_scripts'] ??
            json['script_all']['native_scripts']) as List)
        .map((e) => NativeScript.fromJson(e))
        .toList());
  }
  NativeScriptScriptAll copyWith({List<NativeScript>? nativeScripts}) {
    return NativeScriptScriptAll(nativeScripts ?? this.nativeScripts);
  }

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength([
      type.toCbor(),
      CborListValue.fixedLength(nativeScripts.map((e) => e.toCbor()).toList())
    ]);
  }

  @override
  NativeScriptType get type => NativeScriptType.scriptAll;

  @override
  Map<String, dynamic> toJson() {
    return {
      'script_all': {
        'native_scripts': nativeScripts.map((e) => e.toJson()).toList()
      }
    };
  }
}
