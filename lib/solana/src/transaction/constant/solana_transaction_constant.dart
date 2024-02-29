/// Constants related to Solana transactions.
class SolanaTransactionConstant {
  /// Length of a public key in bytes.
  static const int publicKeyLength = 32;

  /// Size of packet data.
  static const int packetDataSize = 1232;

  /// Mask for the version prefix.
  static const int versionPrefixMask = 0x7f;

  /// Length of a signature in bytes.
  static const int signatureLengthInBytes = 64;

  /// Maximum number of account keys.
  static const int maximumAccountKeys = 256;
}
