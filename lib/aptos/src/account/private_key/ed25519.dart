import 'package:on_chain/aptos/src/account/account.dart';
import 'package:on_chain/aptos/src/keypair/keys/ed25519.dart';

/// Aptos account implementation using the Ed25519 signing scheme.
class AptosEd25519Account extends AptosAccount<AptosEd25519AccountPublicKey,
    AptosAccountAuthenticatorEd25519, AptosEd25519Signature> {
  /// The private key associated with this Ed25519 account.
  final AptosED25519PrivateKey privateKey;

  /// Constructor to initialize the Ed25519 account with a private key.
  AptosEd25519Account(this.privateKey)
      : super(
            scheme: AptosSigningScheme.ed25519,
            publicKey: AptosEd25519AccountPublicKey(privateKey.publicKey));

  /// Sign the digest aand create account's authenticator using Ed25519 private key.
  @override
  AptosAccountAuthenticatorEd25519 signWithAuth(List<int> digest) {
    final signature = sign(digest);
    return AptosAccountAuthenticatorEd25519(
        publicKey: publicKey.publicKey, signature: signature);
  }

  /// Sign the digest using the Ed25519 private key.
  @override
  AptosEd25519Signature sign(List<int> digest) {
    return AptosEd25519Signature(privateKey.sign(digest).signature);
  }
}
