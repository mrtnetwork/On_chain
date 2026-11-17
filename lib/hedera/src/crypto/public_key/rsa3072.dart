import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/crypto/public_key/public_key.dart';
import 'package:on_chain/hedera/src/crypto/types/types.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart';

/// RSA-3072 public key (DER / SPKI bytes).
///
/// Hedera protobuf supports this field; live networks may not verify it yet.
class HederaRsa3072PublicKey extends HederaPublicKey {
  final BuBytes _bytes;

  HederaRsa3072PublicKey._(List<int> bytes)
    : _bytes = bytes.asImmutableBytes,
      super(type: HederaKeyType.rsa3072);

  factory HederaRsa3072PublicKey.fromBytes(List<int> bytes) {
    if (bytes.isEmpty) {
      throw OnChainErrors.hederaPlugin(
        'HederaRsa3072PublicKey.fromBytes',
        reason: 'Public key bytes cannot be empty.',
      );
    }
    return HederaRsa3072PublicKey._(bytes);
  }

  @override
  BuBytes toBytes() => _bytes.clone();

  @override
  bool verifySignature(List<int> message, List<int> signature) {
    throw OnChainErrors.hederaPlugin(
      'HederaRsa3072PublicKey.verifySignature',
      reason: "Unsupported RSA-3072 verifying signature.",
    );
  }

  @override
  List<dynamic> get variables => [_bytes];

  @override
  HederaKey toHederaKey() => HederaKey(rsa3072: toBytes());
}
