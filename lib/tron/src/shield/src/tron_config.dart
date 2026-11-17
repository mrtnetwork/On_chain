class TronShieldConfig {
  /// Max shielded value fits in 64-bit (sun / token smallest unit).
  static const int maxNoteValueBits = 64;

  /// Default memo (512 zero bytes) when sender omits memo.
  static List<int> defaultMemo() => List<int>.filled(512, 0);

  /// TRON shielded tree depth (same as Zcash Sapling).
  static const int merkleDepth = 32;

  /// Minimum padding for private transfers (privacy set).
  /// Mirrors zcash builder: at least 1 spend / 2 outputs after padding.
  static const int minSpends = 1;
  static const int minOutputs = 2;

  /// Nile / Shasta testnet chain ids for real-network tests.
  static const String nileChain = 'Nile';
  static const String shastaChain = 'Shasta';
}
