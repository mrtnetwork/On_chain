/// Unified transaction status across the fullnode API for the block/failed cases.
enum AptosTxStatus {
  /// The transaction is confirmed in a block.
  block,

  /// The transaction was executed with `success: false`.
  failed,
}

/// Fungible-asset balance of an account (wallet `AptosAccountTokenInfo`
/// parity: same three fields).
class AptosFungibleAssetBalance {
  final BigInt balance;
  final bool frozen;
  final String assetType;
  const AptosFungibleAssetBalance({
    required this.balance,
    required this.frozen,
    required this.assetType,
  });
}

/// Fungible-token balance joined with its on-chain metadata (wallet
/// `getAccountFTTokens` parity without the wallet `Token`/`APPImage`
/// wrappers).
class AptosFungibleTokenBalance {
  final BigInt balance;
  final String assetType;
  final bool isFrozen;
  final String name;
  final String symbol;
  final int decimals;
  final String? iconUri;
  const AptosFungibleTokenBalance({
    required this.balance,
    required this.assetType,
    required this.isFrozen,
    required this.name,
    required this.symbol,
    required this.decimals,
    this.iconUri,
  });
}

/// Result of [AptosQuickClientApi.submitTransaction] (wallet `(hash, ok)`
/// record parity).
class AptosSubmitResult {
  /// Transaction hash (server hash, or locally computed on odd responses).
  final String hash;

  /// True when the server answered with a hash.
  final bool submitted;
  const AptosSubmitResult({required this.hash, required this.submitted});
}

/// Fungible-asset metadata for a single asset type (wallet `fetchFaMetadata`
/// parity without the wallet `Token`/`APPImage` wrappers: null when the
/// asset has no indexed metadata).
class AptosFungibleAssetMetadata {
  final String assetType;
  final String name;
  final String symbol;
  final int decimals;
  final String? iconUri;
  const AptosFungibleAssetMetadata({
    required this.assetType,
    required this.name,
    required this.symbol,
    required this.decimals,
    this.iconUri,
  });
}

/// Singly-held v2 non-fungible ownership (wallet `fetchAccountNfts` parity
/// without the wallet `AptosNFToken` wrapper).
class AptosAccountNFT {
  final String tokenDataId;
  final String tokenName;
  final String collectionName;
  const AptosAccountNFT({
    required this.tokenDataId,
    required this.tokenName,
    required this.collectionName,
  });
}

/// A delegation pool with its on-chain totals: the stake picker source
/// for first-time stakers (wallet `AptosDelegationPoolInfo` parity).
class AptosDelegationPoolInfo {
  final String pool;
  final BigInt totalCoins;
  final BigInt commissionPercentage;
  const AptosDelegationPoolInfo({
    required this.pool,
    required this.totalCoins,
    required this.commissionPercentage,
  });
}

/// A live delegation position: the on-chain (active, inactive,
/// pending_inactive) split of one delegator in one pool, read via the
/// `delegation_pool::get_stake` view (wallet `AptosDelegationPosition`
/// parity).
class AptosDelegationPosition {
  final String pool;
  final BigInt active;
  final BigInt inactive;
  final BigInt pendingInactive;
  const AptosDelegationPosition({
    required this.pool,
    required this.active,
    required this.inactive,
    required this.pendingInactive,
  });

  BigInt get total => active + inactive + pendingInactive;
}
