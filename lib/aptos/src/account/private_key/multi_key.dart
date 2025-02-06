import 'package:blockchain_utils/helper/helper.dart';
import 'package:on_chain/aptos/src/account/authenticator/authenticator.dart';
import 'package:on_chain/aptos/src/account/core/account.dart';
import 'package:on_chain/aptos/src/account/public_key/multi_key.dart';
import 'package:on_chain/aptos/src/account/types/types.dart';
import 'package:on_chain/aptos/src/exception/exception.dart';
import 'package:on_chain/aptos/src/keypair/core/keypair.dart';

class AptosMultiKeyAccount extends AptosAccount<AptosMultiKeyAccountPublicKey,
    AptosAccountAuthenticatorMultiKey, AptosMultiKeySignature> {
  final List<AptosBasePrivateKey> privateKeys;
  AptosMultiKeyAccount(
      {required List<AptosBasePrivateKey> privateKeys,
      required super.publicKey})
      : privateKeys = privateKeys.immutable,
        super(scheme: AptosSigningScheme.multikey);

  /// Sign the digest using multiple private keys and create the authenticator.
  /// [signers] can be provided to select specific private keys.
  @override
  AptosAccountAuthenticatorMultiKey signWithAuth(List<int> digest,
      {List<AptosBasePrivateKey>? signers}) {
    final signature = sign(digest, forAuth: true, signers: signers);
    return AptosAccountAuthenticatorMultiKey(
        publicKey: publicKey, signature: signature);
  }

  /// Sign the digest using the appropriate private keys, considering the threshold and bitmap.
  /// [signers] can be provided to select specific private keys. If [forAuth] is true, the function will
  /// break early when the required number of signatures for authentication is reached.
  @override
  AptosMultiKeySignature sign(List<int> digest,
      {List<AptosBasePrivateKey>? signers, bool forAuth = false}) {
    signers = (signers ?? privateKeys)
        .where((e) => publicKey.publicKeys.contains(e.publicKey))
        .toList();
    signers.sort((a, b) => publicKey.publicKeys
        .indexOf(a.publicKey)
        .compareTo(publicKey.publicKeys.indexOf(b.publicKey)));

    const int bit = 128;
    final List<int> bitmap = [0, 0, 0, 0];
    List<AptosAnySignature> signatures = [];
    final List<int> bits = [];
    for (final i in signers) {
      final index = publicKey.publicKeys.indexOf(i.publicKey);
      if (index < 0 || bits.contains(index)) continue;
      int offset = (index / 8).floor();
      bitmap[offset] |= bit >> index % 8;
      final signature = i.sign(digest);
      signatures.add(signature);
      if (forAuth && signatures.length >= publicKey.requiredSignature) {
        break;
      }
    }
    if (signatures.length < publicKey.requiredSignature) {
      throw DartAptosPluginException(
        "Insufficient signatures. Expected ${publicKey.requiredSignature} but ${signatures.length} generated.",
        details: {
          "expected": publicKey.requiredSignature,
          "received": signatures.length
        },
      );
    }
    return AptosMultiKeySignature(signatures: signatures, bitmap: bitmap);
  }
}
