import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/utils/compare/compare.dart';
import 'package:blockchain_utils/utils/compare/hash_code.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/native_script/models/native_script.dart';
import 'package:on_chain/ada/src/models/native_script/models/native_script_type.dart';
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
        cbor.elementAt<CborObject>(0), NativeScriptType.scriptAll);
    return NativeScriptScriptAll(cbor
        .elementAt<CborListValue>(1)
        .valueAsListOf<CborListValue>()
        .map((e) => NativeScript.deserialize(e))
        .toList());
  }
  factory NativeScriptScriptAll.fromJson(Map<String, dynamic> json) {
    final correctJson = json[NativeScriptType.scriptAll.name] ?? json;
    return NativeScriptScriptAll((correctJson['native_scripts'] as List)
        .map((e) => NativeScript.fromJson(e))
        .toList());
  }
  NativeScriptScriptAll copyWith({List<NativeScript>? nativeScripts}) {
    return NativeScriptScriptAll(nativeScripts ?? this.nativeScripts);
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      CborListValue.definite(nativeScripts.map((e) => e.toCbor()).toList())
    ]);
  }

  @override
  NativeScriptType get type => NativeScriptType.scriptAll;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        'native_scripts': nativeScripts.map((e) => e.toJson()).toList()
      }
    };
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! NativeScriptScriptAll) return false;
    return CompareUtils.iterableIsEqual(nativeScripts, other.nativeScripts);
  }

  @override
  int get hashCode => HashCodeGenerator.generateHashCode([type, nativeScripts]);
}
