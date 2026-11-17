// Unified result types for [AdaQuickClientApi] (wallet parity,
// base-native).
//
// One unified type per top call so consumers never touch raw request
// classes. Wallet-only UI/store types stay in the wallet.

/// Unified transaction status (wallet `WalletTransactionStatus` parity for
/// the Cardano cases: Blockfrost only ever returns confirmed transactions,
/// so there is no failed state here).
enum AdaTxStatus {
  /// The transaction is present (confirmed).
  block,

  /// The transaction is unknown (404).
  unknown,
}
