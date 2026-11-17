import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/crypto/private_key/secret_key.dart';
import 'package:on_chain/hedera/src/crypto/public_key/ecdsa384.dart';
import 'package:on_chain/hedera/src/crypto/types/types.dart';

/// ECDSA P-384 secret key.
///
/// Stores key material and public bytes. [sign] must be wired to a P-384
/// backend before use on a network that accepts this algorithm.
class HederaEcdsa384SecretKey extends HederaSecretKey<HederaEcdsa384PublicKey> {
  final SecretBytes _privateBytes;
  final BuBytes? _publicBytes;

  HederaEcdsa384SecretKey._({
    required List<int> privateBytes,
    required List<int>? publicBytes,
  }) : _privateBytes = SecretBytes(privateBytes),
       _publicBytes = publicBytes?.asImmutableBytes,
       super(type: HederaKeyType.ecdsa384);

  factory HederaEcdsa384SecretKey.fromBytes(
    List<int> privateBytes, {
    List<int>? publicBytes,
  }) {
    privateBytes.exc(
      length: 48,
      operation: "HederaEcdsa384SecretKey.fromBytes",
      onErr: () {
        throw OnChainErrors.hederaPlugin(
          'HederaEcdsa384SecretKey.fromBytes',
          reason: 'Invalid ECDSA P-384 private key bytes length.',
        );
      },
    );
    if (publicBytes != null && ![49, 97].contains(publicBytes.length)) {
      throw OnChainErrors.hederaPlugin(
        'HederaEcdsa384SecretKey.fromBytes',
        reason: 'Invalid ECDSA P-384 public key bytes length.',
      );
    }
    return HederaEcdsa384SecretKey._(
      privateBytes: privateBytes,
      publicBytes: publicBytes,
    );
  }

  @override
  SecretBytes toBytes() => _privateBytes.cloneBytes();

  @override
  HederaEcdsa384PublicKey toPublicKey() {
    if (_publicBytes == null) {
      throw OnChainErrors.hederaPlugin(
        'HederaEcdsa384SecretKey.toPublicKey',
        reason: 'Public key bytes were not provided for this P-384 key.',
      );
    }
    return HederaEcdsa384PublicKey.fromBytes(_publicBytes);
  }

  @override
  BuBytes sign(List<int> message) {
    throw OnChainErrors.hederaPlugin(
      'HederaEcdsa384SecretKey.sign',
      reason: "ECDSA P-384 signing not supported.",
    );
  }

  @override
  void dispose() {
    _privateBytes.zero();
  }
}
