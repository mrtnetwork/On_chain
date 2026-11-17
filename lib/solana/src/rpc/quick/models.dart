// Unified result types for [SolanaQuickClientApi] (wallet parity,
// base-native).
//
// Mirrors `TonQuickClientApi` models: one unified type per top call so
// consumers never touch raw request classes. Wallet-only UI/store types
// (`Token`, `APPImage`, `SolanaNetworkToken`, `SolanaSPLToken`,
// `SolanaAccountSPLTokenInfo`) are replaced with plain data below.

import 'package:on_chain/solana/src/address/sol_address.dart';

/// Unified transaction status (wallet `WalletTransactionStatus` parity for
/// the Solana cases).
enum SolanaTxStatus {
  /// The transaction is confirmed in a block (finalized).
  block,

  /// The transaction is known but not finalized yet.
  pending,

  /// The transaction executed with an error.
  failed,

  /// No status found for the signature.
  unknown,
}

/// Associated-token-account address triple (swap `SolanaTokenPDAInfo`
/// parity, base-native).
class SolanaTokenAccountAddress {
  final SolAddress account;
  final SolAddress pdaAddress;
  final SolAddress tokenProgramId;
  const SolanaTokenAccountAddress({
    required this.account,
    required this.pdaAddress,
    required this.tokenProgramId,
  });
}

/// SPL token holding of an account (wallet `getAccountTokens` parity without
/// the wallet `Token` wrapper; `decimals` is null when the mint account is
/// missing instead of throwing).
class SolanaSPLTokenBalance {
  final SolAddress mint;
  final BigInt amount;
  final SolAddress owner;
  final SolAddress tokenAccount;
  final int? decimals;
  const SolanaSPLTokenBalance({
    required this.mint,
    required this.amount,
    required this.owner,
    required this.tokenAccount,
    required this.decimals,
  });
}
