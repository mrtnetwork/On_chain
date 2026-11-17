/// Constants related to Solana transactions.
class SolanaTransactionConstant {
  /// Length of a public key in bytes.
  static const int publicKeyLength = 32;

  /// Size of packet data.
  static const int packetDataSize = 1232;

  /// Maximum raw size of a v1 transaction in bytes (SIMD-0296).
  static const int packetDataSizeV1 = 4096;

  /// Mask for the version prefix.
  static const int versionPrefixMask = 0x7f;

  /// Version prefix byte for v0 messages (`0x80`).
  static const int versionPrefixV0 = 0x80;

  /// Version byte for v1 transactions/messages (`0x81`, SIMD-0385).
  static const int versionPrefixV1 = 0x81;

  /// Length of a signature in bytes.
  static const int signatureLengthInBytes = 64;

  /// Maximum number of account keys.
  static const int maximumAccountKeys = 64;

  /// Maximum number of instructions per transaction (sanitization limit).
  static const int maximumInstructions = 64;

  /// Minimum heap frame size in bytes (v1 default).
  static const int minHeapFrameBytes = 32 * 1024;

  /// Maximum heap frame size in bytes (v1).
  static const int maxHeapFrameBytes = 256 * 1024;
}
