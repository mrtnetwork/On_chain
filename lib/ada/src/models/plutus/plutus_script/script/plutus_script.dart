import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_script/language/language.dart';

class PlutusScript with ADASerialization {
  final List<int> bytes;
  final Language language;

  PlutusScript({required List<int> bytes, required this.language})
      : bytes = BytesUtils.toBytes(bytes, unmodifiable: true);
  factory PlutusScript.fromCborBytes(List<int> cborBytes,
      {Language language = Language.plutusV1}) {
    return PlutusScript.deserialize(CborObject.fromCbor(cborBytes).cast(),
        language: language);
  }
  factory PlutusScript.deserialize(CborBytesValue cbor,
      {Language language = Language.plutusV1}) {
    return PlutusScript(bytes: cbor.value, language: language);
  }
  factory PlutusScript.fromJson(Map<String, dynamic> json) {
    return PlutusScript(
        bytes: BytesUtils.fromHexString(json["bytes"]),
        language: Language.fromName(json["language"]));
  }
  PlutusScript copyWith({List<int>? bytes, Language? language}) {
    return PlutusScript(
        bytes: bytes ?? this.bytes, language: language ?? this.language);
  }

  @override
  CborObject toCbor() {
    return CborBytesValue(bytes);
  }

  ScriptHash toHash() {
    return ScriptHash(
        QuickCrypto.blake2b224Hash([language.scriptHashNameSpace, ...bytes]));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "bytes": BytesUtils.toHexString(bytes),
      "language": language.toJson()
    };
  }
}
