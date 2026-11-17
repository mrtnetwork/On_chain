import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/credential/models/credential_type.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';

/// Represents a stake credential using a script.
class CredentialScript extends Credential {
  /// Constructs a [CredentialScript] with the specified [data].
  CredentialScript(super.data);

  /// Deserializes a [CredentialScript] from CBOR bytes [cbor].
  factory CredentialScript.deserialize(CborBytesValue cbor) {
    return CredentialScript(cbor.value.asImmutableBytes);
  }

  /// Returns the type of this stake credential, which is [CredentialType.script].
  @override
  CredentialType get type => CredentialType.script;
}
