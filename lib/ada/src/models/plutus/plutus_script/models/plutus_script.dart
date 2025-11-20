import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_script/models/language.dart';

class PlutusScript with InternalCborSerialization {
  final List<int> bytes;
  final Language language;

  PlutusScript({required List<int> bytes, required this.language})
      : bytes = bytes.asImmutableBytes;
  factory PlutusScript.fromCborBytes(List<int> cborBytes,
      {Language language = Language.plutusV1}) {
    return PlutusScript.deserialize(
        CborObject.fromCbor(cborBytes).as<CborBytesValue>(),
        language: language);
  }
  factory PlutusScript.deserialize(CborBytesValue cbor,
      {Language language = Language.plutusV1}) {
    return PlutusScript(bytes: cbor.value, language: language);
  }
  factory PlutusScript.fromJson(Map<String, dynamic> json) {
    return PlutusScript(
        bytes: BytesUtils.fromHexString(json['bytes']),
        language: Language.fromName(json['language']));
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
      'bytes': BytesUtils.toHexString(bytes),
      'language': language.toJson()
    };
  }
}
