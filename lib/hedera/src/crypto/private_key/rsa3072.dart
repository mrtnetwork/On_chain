import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/crypto/private_key/secret_key.dart';
import 'package:on_chain/hedera/src/crypto/public_key/rsa3072.dart';
import 'package:on_chain/hedera/src/crypto/types/types.dart';

/// RSA-3072 secret key (PKCS#8 / raw private key bytes).
class HederaRsa3072SecretKey extends HederaSecretKey<HederaRsa3072PublicKey> {
  final SecretBytes _privateBytes;
  final BuBytes? _publicBytes;

  HederaRsa3072SecretKey._({
    required List<int> privateBytes,
    List<int>? publicBytes,
  }) : _privateBytes = SecretBytes(privateBytes),
       _publicBytes = publicBytes?.asImmutableBytes,
       super(type: HederaKeyType.rsa3072);

  factory HederaRsa3072SecretKey.fromBytes(
    List<int> privateBytes, {
    List<int>? publicBytes,
  }) {
    if (privateBytes.isEmpty) {
      throw OnChainErrors.hederaPlugin(
        'HederaRsa3072SecretKey.fromBytes',
        reason: 'Invalid RSA-3072 private key bytes.',
        details: {'length': '${privateBytes.length}'},
      );
    }
    return HederaRsa3072SecretKey._(
      privateBytes: privateBytes,
      publicBytes: publicBytes,
    );
  }

  @override
  SecretBytes toBytes() => _privateBytes.cloneBytes();

  @override
  HederaRsa3072PublicKey toPublicKey() {
    if (_publicBytes == null) {
      throw OnChainErrors.hederaPlugin(
        'HederaRsa3072SecretKey.toPublicKey',
        reason: 'Public key bytes were not provided for this RSA key.',
      );
    }
    return HederaRsa3072PublicKey.fromBytes(_publicBytes);
  }

  @override
  BuBytes sign(List<int> message) {
    throw OnChainErrors.hederaPlugin(
      'HederaRsa3072SecretKey.sign',
      reason: "Unsupported RSA-3072 signing.",
    );
  }

  @override
  void dispose() {
    _privateBytes.zero();
  }
}
