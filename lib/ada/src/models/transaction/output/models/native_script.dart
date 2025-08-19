import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/native_script/models/native_script.dart';
import 'package:on_chain/ada/src/models/transaction/output/models/script_ref.dart';
import 'package:on_chain/ada/src/models/transaction/output/models/script_ref_type.dart';

/// Represents a native script reference.
class ScriptRefNativeScript extends ScriptRef {
  /// The native script.
  final NativeScript script;

  /// Constructs a [ScriptRefNativeScript] instance with the provided [script].
  const ScriptRefNativeScript(this.script) : super(ScriptRefType.nativeScript);

  /// Deserializes a [ScriptRefNativeScript] instance from CBOR.
  factory ScriptRefNativeScript.deserialize(CborListValue cbor) {
    ScriptRefType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: ScriptRefType.nativeScript);
    return ScriptRefNativeScript(
        NativeScript.deserialize(cbor.elementAt<CborListValue>(1)));
  }
  factory ScriptRefNativeScript.fromJson(Map<String, dynamic> json) {
    return ScriptRefNativeScript(NativeScript.fromJson(json['script']));
  }
  ScriptRefNativeScript copyWith({NativeScript? script}) {
    return ScriptRefNativeScript(script ?? this.script);
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([type.toCbor(), script.toCbor()]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {'script': script.toJson()}
    };
  }
}
