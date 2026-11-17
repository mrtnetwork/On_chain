import 'package:blockchain_utils/blockchain_utils.dart';

/// Contains constants related to Ada transactions.
class AdaTransactionConstant {
  /// The size of BLAKE2b-256 digests.
  static const int blake2b256DigestSize = QuickCrypto.blake2b256DigestSize;

  /// The size of BLAKE2b-224 digests.
  static const int blake2b224DigestSize = QuickCrypto.blake2b224DigestSize;

  /// The length of transaction proofs.
  static const int proofLength = 80;

  /// The length of transaction signatures.
  static const int signatureLength = 64;

  /// The length of IPv4 addresses.
  static const int ipv4Length = 4;

  /// The length of IPv6 addresses.
  static const int ipv6Length = 16;
}
