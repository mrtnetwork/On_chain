import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/models/credential/models/credential_type.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';

/// Represents a stake credential using a public key.
class CredentialKey extends Credential {
  /// Constructs a [CredentialKey] with the specified [data].
  CredentialKey(super.data);

  /// Constructs a [CredentialKey] from a public key [pubKeyBytes].
  /// It derives the credential from the public key bytes using hashing.
  CredentialKey.fromPublicKey(List<int> pubKeyBytes)
      : super(AdaAddressUtils.publicKeyToHash(pubKeyBytes));

  /// Deserializes a [CredentialKey] from CBOR bytes [cbor].
  factory CredentialKey.deserialize(CborBytesValue cbor) {
    return CredentialKey(cbor.value);
  }

  /// Returns the type of this stake credential, which is [CredentialType.key].
  @override
  CredentialType get type => CredentialType.key;
}
