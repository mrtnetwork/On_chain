// Unified result types for [EthereumQuickClientApi] (base-native).
//
// One unified type per top call so consumers never touch raw request
// classes. Wallet-only UI/store types are replaced with plain data below.

/// Contract standards probed by [EthereumQuickClientApi], with the
/// interface ids used on the wire.
///
/// NOTE: ERC-20 has no real ERC-165 id; `0x36372b07`
enum EthereumContractStandard {
  erc20('0x36372b07'),
  erc721('0x80ac58cd'),
  erc1155('0xd9b67a26'),
  erc721Enumerable('0x780e9d63');

  /// Interface id hex passed to `supportsInterface(bytes4)`.
  final String interfaceId;
  const EthereumContractStandard(this.interfaceId);
}

/// Unified transaction status (wallet `WalletTransactionStatus` parity for
/// the Ethereum cases).
enum EthTxStatus {
  /// No receipt found for the hash yet.
  unknown,

  /// The receipt reports `status: false`.
  failed,

  /// The receipt is present and successful.
  block,
}

/// ERC-20 token metadata (wallet `getErc20Details` parity without the wallet
/// `Token` wrapper).
class ERC20TokenMetadata {
  final String name;
  final String symbol;
  final int decimals;
  const ERC20TokenMetadata({
    required this.name,
    required this.symbol,
    required this.decimals,
  });
}

/// ERC-20 token holding (wallet `getAccountERC20Token` parity without the
/// wallet token wrappers; works for any [SolidityAddress]).
class ERC20TokenBalance {
  final String contract;
  final BigInt balance;
  final String name;
  final String symbol;
  final int decimals;
  const ERC20TokenBalance({
    required this.contract,
    required this.balance,
    required this.name,
    required this.symbol,
    required this.decimals,
  });
}
