import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_script/script/plutus_script.dart';
import 'package:on_chain/ada/src/models/transaction/output/script_ref/core/script_ref.dart';
import 'package:on_chain/ada/src/models/transaction/output/script_ref/core/script_ref_type.dart';

/// Represents a Plutus script reference.
class ScriptRefPlutusScript extends ScriptRef {
  /// The Plutus script.
  final PlutusScript script;

  /// Constructs a [ScriptRefPlutusScript] instance with the provided [script].
  const ScriptRefPlutusScript(this.script);

  /// Deserializes a [ScriptRefPlutusScript] instance from CBOR.
  factory ScriptRefPlutusScript.deserialize(CborListValue cbor) {
    ScriptRefType.deserialize(cbor.getIndex(0),
        validate: ScriptRefType.plutusScript);
    return ScriptRefPlutusScript(PlutusScript.deserialize(cbor.getIndex(1)));
  }
  factory ScriptRefPlutusScript.fromJson(Map<String, dynamic> json) {
    return ScriptRefPlutusScript(PlutusScript.fromJson(
        json['script'] ?? json['plutus_script']['script']));
  }
  ScriptRefPlutusScript copyWith({PlutusScript? script}) {
    return ScriptRefPlutusScript(script ?? this.script);
  }

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength([type.toCbor(), script.toCbor()]);
  }

  @override
  ScriptRefType get type => ScriptRefType.plutusScript;
  @override
  Map<String, dynamic> toJson() {
    return {
      'plutus_script': {'script': script.toJson()}
    };
  }
}
