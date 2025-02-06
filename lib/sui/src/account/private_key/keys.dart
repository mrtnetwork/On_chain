import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/account/core/account.dart';
import 'package:on_chain/sui/src/account/public_key/keys.dart';
import 'package:on_chain/sui/src/keypair/utils/utils.dart';
import 'package:on_chain/sui/src/exception/exception.dart';
import 'package:on_chain/sui/src/keypair/keypair.dart';

class SuiEd25519Account
    extends SuiAccount<SuiEd25519AccountPublicKey, SuiEd25519Signature> {
  final SuiED25519PrivateKey privateKey;
  SuiEd25519Account(this.privateKey)
      : super(
            publicKey: SuiEd25519AccountPublicKey(privateKey.publicKey),
            scheme: SuiSigningScheme.ed25519);

  @override
  SuiEd25519Signature signTransaction(List<int> txbytes,
      {bool hashDigest = true}) {
    final digest = SuiCryptoUtils.generateTransactionDigest(
        txBytes: txbytes, hashDigest: hashDigest);
    final signature = privateKey.sign(digest);
    return SuiEd25519Signature(
        publicKey: publicKey.publicKey, signature: signature);
  }

  @override
  SuiEd25519Signature signPersonalMessage(List<int> message) {
    final digest = SuiCryptoUtils.generatePersonalMessageDigest(message);
    final signature = privateKey.sign(digest);
    return SuiEd25519Signature(
        publicKey: publicKey.publicKey, signature: signature);
  }
}

class SuiSecp256k1Account
    extends SuiAccount<SuiSecp256k1AccountPublicKey, SuiSecp256k1Signature> {
  final SuiSecp256k1PrivateKey privateKey;
  SuiSecp256k1Account(this.privateKey)
      : super(
            publicKey: SuiSecp256k1AccountPublicKey(privateKey.publicKey),
            scheme: SuiSigningScheme.secp256k1);

  @override
  SuiSecp256k1Signature signTransaction(List<int> txbytes,
      {bool hashDigest = true}) {
    final digest = SuiCryptoUtils.generateTransactionDigest(
        txBytes: txbytes, hashDigest: hashDigest);
    final signature = privateKey.sign(digest);
    return SuiSecp256k1Signature(
        publicKey: publicKey.publicKey, signature: signature);
  }

  @override
  SuiSecp256k1Signature signPersonalMessage(List<int> message) {
    final digest = SuiCryptoUtils.generatePersonalMessageDigest(message);
    final signature = privateKey.sign(digest);
    return SuiSecp256k1Signature(
        publicKey: publicKey.publicKey, signature: signature);
  }
}

class SuiSecp256r1Account
    extends SuiAccount<SuiSecp256r1AccountPublicKey, SuiSecp256r1Signature> {
  final SuiSecp256r1PrivateKey privateKey;
  SuiSecp256r1Account(this.privateKey)
      : super(
            publicKey: SuiSecp256r1AccountPublicKey(privateKey.publicKey),
            scheme: SuiSigningScheme.secp256r1);

  @override
  SuiSecp256r1Signature signTransaction(List<int> txbytes,
      {bool hashDigest = true}) {
    final digest = SuiCryptoUtils.generateTransactionDigest(
        txBytes: txbytes, hashDigest: hashDigest);
    final signature = privateKey.sign(digest);
    return SuiSecp256r1Signature(
        publicKey: publicKey.publicKey, signature: signature);
  }

  @override
  SuiSecp256r1Signature signPersonalMessage(List<int> message) {
    final digest = SuiCryptoUtils.generatePersonalMessageDigest(message);
    final signature = privateKey.sign(digest);
    return SuiSecp256r1Signature(
        publicKey: publicKey.publicKey, signature: signature);
  }
}

class SuiMultisigAccount
    extends SuiAccount<SuiMultisigAccountPublicKey, SuiMultisigSignature> {
  final List<SuiBasePrivateKey> privateKeys;
  SuiMultisigAccount(
      {required List<SuiBasePrivateKey> privateKeys, required super.publicKey})
      : privateKeys = privateKeys.immutable,
        super(scheme: SuiSigningScheme.multisig);

  @override
  SuiMultisigSignature signTransaction(List<int> txbytes,
      {List<SuiBasePrivateKey>? signers, bool hashDigest = true}) {
    signers = List<SuiBasePrivateKey>.from(signers ?? privateKeys);
    signers = signers
        .where((e) {
          final key = e.publicKey;
          return publicKey.publicKeys.any((i) => i.publicKey == key);
        })
        .toSet()
        .toList();
    signers.sort((a, b) {
      final firstKey = a.publicKey;
      final secoundKey = b.publicKey;
      return publicKey.publicKeys
          .indexWhere((e) => e.publicKey == firstKey)
          .compareTo(publicKey.publicKeys
              .indexWhere((e) => e.publicKey == secoundKey));
    });
    final List<SuiGenericSignature> signatures = [];
    final digest = SuiCryptoUtils.generateTransactionDigest(
        txBytes: txbytes, hashDigest: hashDigest);
    int weight = 0;
    List<int> bits = [];
    int bitMap = 0;
    for (final i in signers) {
      final pubKey = i.publicKey;
      final index =
          publicKey.publicKeys.indexWhere((e) => e.publicKey == pubKey);
      if (index >= 0 && !bits.contains(index)) {
        final pubKeyInfo = publicKey.publicKeys.elementAt(index);
        final signature = i.sign(digest);
        signatures.add(signature);
        weight += pubKeyInfo.weight;
        bitMap |= 1 << index;
        if (weight >= publicKey.threshold) break;
      }
    }
    if (weight < publicKey.threshold) {
      throw DartSuiPluginException(
        "Insufficient signatures.",
        details: {"threshold": publicKey.threshold, "weight": weight},
      );
    }
    return SuiMultisigSignature(
        publicKey: publicKey, signatures: signatures, bitmap: bitMap);
  }

  @override
  SuiMultisigSignature signPersonalMessage(List<int> message) {
    final digest = SuiCryptoUtils.generatePersonalMessageDigest(message);
    return signTransaction(digest, hashDigest: false);
  }
}
