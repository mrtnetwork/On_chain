import 'package:on_chain/aptos/src/account/authenticator/authenticator.dart';
import 'package:on_chain/aptos/src/account/core/account.dart';
import 'package:on_chain/aptos/src/account/public_key/single_key.dart';
import 'package:on_chain/aptos/src/account/types/types.dart';
import 'package:on_chain/aptos/src/keypair/core/keypair.dart';

class AptosSingleKeyAccount extends AptosAccount<AptosSingleKeyAccountPublicKey,
    AptosAccountAuthenticatorSingleKey, AptosAnySignature> {
  final AptosBasePrivateKey privateKey;
  AptosSingleKeyAccount(this.privateKey)
      : super(
            scheme: AptosSigningScheme.signleKey,
            publicKey: AptosSingleKeyAccountPublicKey(privateKey.publicKey));
  // Signs the digest with the private key and create authenticator.
  @override
  AptosAccountAuthenticatorSingleKey signWithAuth(List<int> digest) {
    final signature = privateKey.sign(digest);
    return AptosAccountAuthenticatorSingleKey(
        publicKey: publicKey.publicKey, signature: signature);
  }

  /// Signs the digest with the private key and returns the signature.
  @override
  AptosAnySignature sign(List<int> digest) {
    return privateKey.sign(digest);
  }
}
