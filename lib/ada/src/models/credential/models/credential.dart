import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/credential/models/credential_type.dart';
import 'package:on_chain/ada/src/models/utils/utils.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/credential/models/key.dart';
import 'package:on_chain/ada/src/models/credential/models/script.dart';
import 'package:on_chain/ada/src/models/constants/constant.dart';

/// Represents a stake credential.
abstract class Credential with InternalCborSerialization {
  final List<int> data;

  /// Constructs a [Credential] instance with the specified [hashBytes].
  Credential(List<int> hashBytes)
      : data = AdaTransactionUtils.validateFixedLengthBytes(
            bytes: hashBytes,
            length: AdaTransactionConstant.blake2b224DigestSize);

  /// Deserializes a [Credential] from a CBOR list value [cbor].
  factory Credential.deserialize(CborListValue cbor) {
    final type = CredentialType.deserialize(cbor.elementAt<CborIntValue>(0));
    switch (type) {
      case CredentialType.key:
        return CredentialKey.deserialize(cbor.elementAt<CborBytesValue>(1));
      default:
        return CredentialScript.deserialize(cbor.elementAt<CborBytesValue>(1));
    }
  }
  factory Credential.fromJson(Map<String, dynamic> json) {
    final type = CredentialType.fromName(json.keys.firstOrNull);
    final bytes = BytesUtils.fromHexString(json[type.name]);
    switch (type) {
      case CredentialType.key:
        return CredentialKey(bytes);
      default:
        return CredentialScript(bytes);
    }
  }

  /// Returns the type of the stake credential.
  CredentialType get type;

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      CborBytesValue(data),
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {type.name: BytesUtils.toHexString(data)};
  }
}
