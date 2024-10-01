import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/transaction/output/script_ref/core/script_ref_type.dart';
import 'package:on_chain/ada/src/models/transaction/output/script_ref/refs/native_script.dart';
import 'package:on_chain/ada/src/models/transaction/output/script_ref/refs/plutus_script.dart';

/// Abstract class representing a script reference.
abstract class ScriptRef with ADASerialization {
  static const List<int> _tag = [24];
  const ScriptRef();

  /// Deserializes a [ScriptRef] instance from CBOR.
  factory ScriptRef.deserialize(CborObject cbor) {
    if (cbor.hasType<CborTagValue>()) {
      final cborTag = cbor.cast<CborTagValue>();
      if (!BytesUtils.bytesEqual(cborTag.tags, _tag)) {
        throw ADAPluginException("Invalid ScriptRef cbor tag.",
            details: {"Excepted": _tag, "Tag": cborTag.tags});
      }
      cbor = CborObject.fromCbor(cborTag.getValue<List<int>>()).cast();
    }
    final CborListValue cborList = cbor.cast();
    final type = ScriptRefType.deserialize(cborList.getIndex(0));
    if (type == ScriptRefType.plutusScript) {
      return ScriptRefPlutusScript.deserialize(cborList);
    }
    return ScriptRefNativeScript.deserialize(cborList);
  }
  factory ScriptRef.fromJson(Map<String, dynamic> json) {
    final ScriptRefType type;
    try {
      type = ScriptRefType.fromName(json.keys.first);
    } on StateError {
      throw ADAPluginException("Invalid ScriptRef json.",
          details: {"json": json});
    }
    switch (type) {
      case ScriptRefType.nativeScript:
        return ScriptRefNativeScript.fromJson(json);
      default:
        return ScriptRefPlutusScript.fromJson(json);
    }
  }

  /// The type of the script reference.
  abstract final ScriptRefType type;

  /// Converts the script reference to CBOR.
  CborObject toScriptRefCbor() {
    return CborTagValue(CborBytesValue(toCbor().encode()), _tag);
  }
}
