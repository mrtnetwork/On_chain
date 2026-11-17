/// Shield constants shared by TRON + generic Sapling.
class ShieldNoteConst {
  /// 1 (lead byte) + 11 (diversifier) + 8 (value) + 32 (rseed/rcm).
  static const int compactNoteSize = 1 + 11 + 8 + 32;
  static const int memoLength = 512;

  /// Full note plaintext size (compact + memo).
  static const int notePlaintextSize = compactNoteSize + memoLength;

  /// pk_d (32) + esk (32).
  static const int outPlaintextSize = 32 + 32;

  static const int aeadTagSize = 16;

  /// encCiphertext = plaintext + tag.
  static const int encCiphertextSize = notePlaintextSize + aeadTagSize;

  /// outCiphertext = outPlaintext + tag.
  static const int outCiphertextSize = outPlaintextSize + aeadTagSize;

  static const int outgoingCipherKeyLen = 32;

  /// TRON + Zcash Sapling tree depth.
  static const int noteCommitmentTreeDepth = 32;
  static const int shardHeight = 16;
}
