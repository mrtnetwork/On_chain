import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/native_script/core/native_script.dart';
import 'package:on_chain/ada/src/models/native_script/core/native_script_type.dart';
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
        cbor.getIndex(0), NativeScriptType.scriptNOfK);
    return NativeScriptScriptNOfK(
      n: cbor.getIndex<CborIntValue>(1).value,
      nativeScripts: cbor
          .getIndex<CborListValue>(2)
          .value
          .map((e) => NativeScript.deserialize(e))
          .toList(),
    );
  }
  NativeScriptScriptNOfK copyWith({int? n, List<NativeScript>? nativeScripts}) {
    return NativeScriptScriptNOfK(
        n: n ?? this.n, nativeScripts: nativeScripts ?? this.nativeScripts);
  }

  factory NativeScriptScriptNOfK.fromJson(Map<String, dynamic> json) {
    return NativeScriptScriptNOfK(
        nativeScripts: ((json['native_scripts'] ??
                json['script_n_of_k']['native_scripts']) as List)
            .map((e) => NativeScript.fromJson(e))
            .toList(),
        n: json['n'] ?? json['script_n_of_k']['n']);
  }

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength([
      type.toCbor(),
      CborIntValue(n),
      CborListValue.fixedLength(nativeScripts.map((e) => e.toCbor()).toList())
    ]);
  }

  @override
  NativeScriptType get type => NativeScriptType.scriptNOfK;

  @override
  Map<String, dynamic> toJson() {
    return {
      'script_n_of_k': {
        'n': n,
        'native_scripts': nativeScripts.map((e) => e.toJson()).toList(),
      }
    };
  }
}
