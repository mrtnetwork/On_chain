import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/crypto/public_key/public_key.dart';
import 'package:on_chain/hedera/src/crypto/types/types.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart';

/// ECDSA P-384 public key.
///
/// Hedera protobuf supports this field; live networks may not verify it yet.
/// Wire in a P-384 verifier when your crypto backend provides one.
class HederaEcdsa384PublicKey extends HederaPublicKey {
  final BuBytes _bytes;

  HederaEcdsa384PublicKey._(List<int> bytes)
    : _bytes = bytes.asImmutableBytes,
      super(type: HederaKeyType.ecdsa384);

  factory HederaEcdsa384PublicKey.fromBytes(List<int> bytes) {
    if (bytes.isEmpty) {
      throw OnChainErrors.hederaPlugin(
        'HederaEcdsa384PublicKey.fromBytes',
        reason: 'Public key bytes cannot be empty.',
      );
    }
    return HederaEcdsa384PublicKey._(bytes);
  }

  @override
  BuBytes toBytes() => _bytes.clone();

  @override
  bool verifySignature(List<int> message, List<int> signature) {
    throw OnChainErrors.hederaPlugin(
      'HederaEcdsa384PublicKey.verifySignature',
      reason: "Unsupported ECDSA P-384 verifying signature.",
    );
  }

  @override
  List<dynamic> get variables => [_bytes];

  @override
  HederaKey toHederaKey() => HederaKey(ecdsa384: toBytes());
}
