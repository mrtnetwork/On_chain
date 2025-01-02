import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/native_script/core/native_script.dart';
import 'package:on_chain/ada/src/models/transaction/output/script_ref/core/script_ref.dart';
import 'package:on_chain/ada/src/models/transaction/output/script_ref/core/script_ref_type.dart';

/// Represents a native script reference.
class ScriptRefNativeScript extends ScriptRef {
  /// The native script.
  final NativeScript script;

  /// Constructs a [ScriptRefNativeScript] instance with the provided [script].
  const ScriptRefNativeScript(this.script);

  /// Deserializes a [ScriptRefNativeScript] instance from CBOR.
  factory ScriptRefNativeScript.deserialize(CborListValue cbor) {
    ScriptRefType.deserialize(cbor.getIndex(0),
        validate: ScriptRefType.nativeScript);
    return ScriptRefNativeScript(NativeScript.deserialize(cbor.getIndex(1)));
  }
  factory ScriptRefNativeScript.fromJson(Map<String, dynamic> json) {
    return ScriptRefNativeScript(NativeScript.fromJson(
        json['script'] ?? json['native_script']['script']));
  }
  ScriptRefNativeScript copyWith({NativeScript? script}) {
    return ScriptRefNativeScript(script ?? this.script);
  }

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength([type.toCbor(), script.toCbor()]);
  }

  @override
  ScriptRefType get type => ScriptRefType.nativeScript;
  @override
  Map<String, dynamic> toJson() {
    return {
      'native_script': {'script': script.toJson()}
    };
  }
}
