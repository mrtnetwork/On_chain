import 'package:blockchain_utils/helper/helper.dart';
import 'package:on_chain/aptos/src/account/authenticator/authenticator.dart';
import 'package:on_chain/aptos/src/account/core/account.dart';
import 'package:on_chain/aptos/src/account/public_key/multi_ed25519.dart';
import 'package:on_chain/aptos/src/account/types/types.dart';
import 'package:on_chain/aptos/src/exception/exception.dart';
import 'package:on_chain/aptos/src/keypair/keys/ed25519.dart';

/// Aptos account implementation for multi-signature Ed25519 accounts.
class AptosMultiEd25519Account extends AptosAccount<
    AptosMultiEd25519AccountPublicKey,
    AptosAccountAuthenticatorMultiEd25519,
    AptosMultiEd25519Signature> {
  /// List of private keys for signing transactions.
  final List<AptosED25519PrivateKey> privateKeys;

  /// Constructor to initialize the multi-signature Ed25519 account with a list of private keys.
  AptosMultiEd25519Account(
      {required List<AptosED25519PrivateKey> privateKeys,
      required super.publicKey})
      : privateKeys = privateKeys.immutable,
        super(scheme: AptosSigningScheme.multiEd25519);

  /// Sign the digest using multiple private keys and create the authenticator.
  /// [signers] can be provided to select specific private keys.
  @override
  AptosAccountAuthenticatorMultiEd25519 signWithAuth(List<int> digest,
      {List<AptosED25519PrivateKey>? signers}) {
    final signature = sign(digest, signers: signers, forAuth: true);
    return AptosAccountAuthenticatorMultiEd25519(
        publicKey: publicKey, signature: signature);
  }

  /// Sign the digest using the appropriate private keys, considering the threshold and bitmap.
  /// [signers] can be provided to select specific private keys. If [forAuth] is true, the function will
  /// break early when the required number of signatures for authentication is reached.
  @override
  AptosMultiEd25519Signature sign(List<int> digest,
      {List<AptosED25519PrivateKey>? signers, bool forAuth = false}) {
    signers = (signers ?? privateKeys)
        .where((e) => publicKey.publicKeys.contains(e.publicKey))
        .toList();
    signers.sort((a, b) => publicKey.publicKeys
        .indexOf(a.publicKey)
        .compareTo(publicKey.publicKeys.indexOf(b.publicKey)));

    int bit = 128;
    List<int> bitmap = [0, 0, 0, 0];
    List<AptosEd25519Signature> signatures = [];
    List<int> bits = [];
    for (final i in signers) {
      final index = publicKey.publicKeys.indexOf(i.publicKey);
      if (index < 0 || bits.contains(index)) continue;
      int offset = (index / 8).floor();
      bitmap[offset] |= bit >> index % 8;
      final signature = AptosEd25519Signature(i.sign(digest).signature);
      signatures.add(signature);
      bits.add(index);
      if (forAuth && signatures.length >= publicKey.threshold) {
        break;
      }
    }
    if (signatures.length < publicKey.threshold) {
      throw DartAptosPluginException(
        "Insufficient signatures. Expected ${publicKey.threshold} but ${signatures.length} generated.",
        details: {
          "expected": publicKey.threshold,
          "received": signatures.length
        },
      );
    }
    return AptosMultiEd25519Signature(signatures: signatures, bitmap: bitmap);
  }
}
