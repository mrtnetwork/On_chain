import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:on_chain/aptos/src/account/authenticator/authenticator.dart';
import 'package:on_chain/aptos/src/account/types/types.dart';
import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/exception/exception.dart';
import 'package:on_chain/aptos/src/keypair/core/keypair.dart';
import 'package:on_chain/bcs/serialization/serialization.dart';

/// Abstract class representing an Aptos account with public key, authenticator, and signature.
abstract class AptosAccount<
    PUBLICKEY extends AptosAccountPublicKey,
    AUTHENTICATOR extends AptosAccountAuthenticator,
    SIGNATURE extends AptosSignature> {
  /// The signing scheme used for this account.
  final AptosSigningScheme scheme;

  /// The public key associated with this account.
  final PUBLICKEY publicKey;

  /// Constructor to initialize the Aptos account with a scheme and public key.
  const AptosAccount({required this.scheme, required this.publicKey});

  /// Sign and account's authenticator.
  AUTHENTICATOR signWithAuth(List<int> digest);

  /// Sign the given digest.
  SIGNATURE sign(List<int> digest);

  /// Get the address corresponding to the public key of this account.
  AptosAddress toAddress() {
    return publicKey.toAddress();
  }
}

/// Abstract class representing an Aptos account public key with BCS serialization.
abstract class AptosAccountPublicKey extends BcsSerialization
    implements AptosPublicKey {
  /// The signing scheme used by this public key.
  final AptosSigningScheme scheme;

  /// Constructor to initialize the public key with a signing scheme.
  const AptosAccountPublicKey({required this.scheme});

  /// Convert the public key to an Aptos address.
  @override
  AptosAddress toAddress();

  /// Convert the public key to a byte array.
  @override
  List<int> toBytes();

  /// Convert the public key to a hexadecimal string.
  @override
  String toHex({bool lowerCase = true, String prefix = ''}) {
    return BytesUtils.toHexString(toBytes(),
        prefix: prefix, lowerCase: lowerCase);
  }

  /// signature must a valid aptos signature serialized as BCS (AnySignature,ED25519Signature,MultiKeySignature or...);
  bool verifySignature(
      {required List<int> message, required List<int> signature});

  T cast<T extends AptosAccountPublicKey>() {
    if (this is! T) {
      throw DartAptosPluginException("Invalid public key.",
          details: {"expected": "$T", "type": scheme.name});
    }
    return this as T;
  }
}
