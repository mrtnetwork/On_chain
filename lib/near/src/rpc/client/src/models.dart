// Unified result types for [NearQuickClientApi] (base-native).
//
// One unified type per top call so consumers never touch raw request classes.

/// Unified transaction status (wallet `WalletTransactionStatus` parity for
/// the NEAR cases).
enum NearTxStatus {
  /// An execution outcome reports success.
  block,

  /// An execution outcome reports failure.
  failed,

  /// Execution is still starting / started.
  pending,

  /// The transaction is unknown to the node.
  unknown,
}
