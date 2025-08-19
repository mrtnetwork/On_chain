import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/utils/compare/compare.dart';
import 'package:blockchain_utils/utils/compare/hash_code.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/native_script/models/native_script.dart';
import 'package:on_chain/ada/src/models/native_script/models/native_script_type.dart';
import 'package:on_chain/ada/src/models/native_script/utils/native_script_utils.dart';

/// Represents a native script that requires N of the provided scripts to be satisfied.
class NativeScriptScriptNOfK extends NativeScript {
  /// The threshold value N.
  final int n;

  /// The list of native scripts.
  final List<NativeScript> nativeScripts;

  /// Constructs a [NativeScriptScriptNOfK].
  NativeScriptScriptNOfK({
    required this.n,
    required List<NativeScript> nativeScripts,
  }) : nativeScripts = List<NativeScript>.unmodifiable(nativeScripts);

  /// Deserializes a [NativeScriptScriptNOfK] from CBOR.
  factory NativeScriptScriptNOfK.deserialize(CborListValue cbor) {
    NativeScriptUtils.validateCborTypeObject(
        cbor.elementAt<CborObject>(0), NativeScriptType.scriptNOfK);
    return NativeScriptScriptNOfK(
      n: cbor.elementAt<CborIntValue>(1).value,
      nativeScripts: cbor
          .elementAt<CborListValue>(2)
          .valueAsListOf<CborListValue>()
          .map((e) => NativeScript.deserialize(e))
          .toList(),
    );
  }
  NativeScriptScriptNOfK copyWith({int? n, List<NativeScript>? nativeScripts}) {
    return NativeScriptScriptNOfK(
        n: n ?? this.n, nativeScripts: nativeScripts ?? this.nativeScripts);
  }

  factory NativeScriptScriptNOfK.fromJson(Map<String, dynamic> json) {
    final correctJson = json[NativeScriptType.scriptNOfK.name] ?? json;
    return NativeScriptScriptNOfK(
        nativeScripts: (correctJson['native_scripts'] as List)
            .map((e) => NativeScript.fromJson(e))
            .toList(),
        n: correctJson['n']);
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      CborIntValue(n),
      CborListValue.definite(nativeScripts.map((e) => e.toCbor()).toList())
    ]);
  }

  @override
  NativeScriptType get type => NativeScriptType.scriptNOfK;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        'n': n,
        'native_scripts': nativeScripts.map((e) => e.toJson()).toList(),
      }
    };
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! NativeScriptScriptNOfK) return false;
    return n == other.n &&
        CompareUtils.iterableIsEqual(nativeScripts, other.nativeScripts);
  }

  @override
  int get hashCode =>
      HashCodeGenerator.generateHashCode([n, type, nativeScripts]);
}
