import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/transaction/output/models/script_ref_type.dart';
import 'package:on_chain/ada/src/models/transaction/output/models/native_script.dart';
import 'package:on_chain/ada/src/models/transaction/output/models/plutus_script.dart';

/// Abstract class representing a script reference.
abstract class ScriptRef with ADASerialization {
  static const List<int> _tag = [24];

  /// The type of the script reference.
  final ScriptRefType type;

  const ScriptRef(this.type);

  /// Deserializes a [ScriptRef] instance from CBOR.
  factory ScriptRef.deserialize(CborObject cbor) {
    if (cbor.hasType<CborTagValue>()) {
      final cborTag = cbor.as<CborTagValue>();
      if (!BytesUtils.bytesEqual(cborTag.tags, _tag)) {
        throw ADAPluginException('Invalid ScriptRef cbor tag.',
            details: {'expected': _tag, 'Tag': cborTag.tags});
      }
      cbor = CborObject.fromCbor(
          cborTag.valueAs<CborBytesValue>("ScriptRef").value);
    }
    final CborListValue cborList = cbor.as("ScriptRef");
    final type = ScriptRefType.deserialize(cborList.elementAt<CborIntValue>(0));
    switch (type) {
      case ScriptRefType.nativeScript:
        return ScriptRefNativeScript.deserialize(cborList);
      case ScriptRefType.plutusScriptV1:
      case ScriptRefType.plutusScriptV2:
      case ScriptRefType.plutusScriptV3:
        return ScriptRefPlutusScript.deserialize(cborList);
      default:
        throw ADAPluginException('Invalid ScriptRef type.');
    }
  }
  factory ScriptRef.fromJson(Map<String, dynamic> json) {
    final ScriptRefType type = ScriptRefType.fromName(json.keys.firstOrNull);
    switch (type) {
      case ScriptRefType.nativeScript:
        return ScriptRefNativeScript.fromJson(json[type.name]);
      case ScriptRefType.plutusScriptV1:
      case ScriptRefType.plutusScriptV2:
      case ScriptRefType.plutusScriptV3:
        return ScriptRefPlutusScript.fromJson(json[type.name]);
      default:
        throw ADAPluginException('Invalid ScriptRef type.');
    }
  }

  /// Converts the script reference to CBOR.
  CborObject toScriptRefCbor() {
    return CborTagValue(CborBytesValue(toCbor().encode()), _tag);
  }

  @override
  Map<String, dynamic> toJson();
}
