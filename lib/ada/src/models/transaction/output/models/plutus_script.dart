import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_script/models/plutus_script.dart';
import 'package:on_chain/ada/src/models/transaction/output/models/script_ref.dart';
import 'package:on_chain/ada/src/models/transaction/output/models/script_ref_type.dart';

/// Represents a Plutus script reference.
class ScriptRefPlutusScript extends ScriptRef {
  /// The Plutus script.
  final PlutusScript script;

  /// Constructs a [ScriptRefPlutusScript] instance with the provided [script].
  ScriptRefPlutusScript(this.script)
      : super(ScriptRefType.fromPlutusLanguage(script.language));

  /// Deserializes a [ScriptRefPlutusScript] instance from CBOR.
  factory ScriptRefPlutusScript.deserialize(CborListValue cbor) {
    final type = ScriptRefType.deserialize(cbor.elementAt<CborIntValue>(0));
    return ScriptRefPlutusScript(PlutusScript.deserialize(
        cbor.elementAt<CborBytesValue>(1),
        language: type.toPlutusLanguage()));
  }
  factory ScriptRefPlutusScript.fromJson(Map<String, dynamic> json) {
    return ScriptRefPlutusScript(PlutusScript.fromJson(json['script']));
  }
  ScriptRefPlutusScript copyWith({PlutusScript? script}) {
    return ScriptRefPlutusScript(script ?? this.script);
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
