/// A class containing constants representing various Solana RPC methods.
class SolanaRequestMethods {
  final String value;

  /// Constructs a [SolanaRequestMethods] instance with a specific value.
  const SolanaRequestMethods._(this.value);

  static const SolanaRequestMethods getLatestBlockhash =
      SolanaRequestMethods._('getLatestBlockhash');
  static const SolanaRequestMethods getMinimumBalanceForRentExemption =
      SolanaRequestMethods._('getMinimumBalanceForRentExemption');
  static const SolanaRequestMethods sendTransaction =
      SolanaRequestMethods._('sendTransaction');
  static const SolanaRequestMethods simulateTransaction =
      SolanaRequestMethods._('simulateTransaction');
  static const SolanaRequestMethods getBalance =
      SolanaRequestMethods._('getBalance');
  static const SolanaRequestMethods getProgramAccounts =
      SolanaRequestMethods._('getProgramAccounts');
  static const SolanaRequestMethods getSignaturesForAddress =
      SolanaRequestMethods._('getSignaturesForAddress');
  static const SolanaRequestMethods getTransaction =
      SolanaRequestMethods._('getTransaction');
  static const SolanaRequestMethods getAccountInfo =
      SolanaRequestMethods._('getAccountInfo');
  static const SolanaRequestMethods getBlock =
      SolanaRequestMethods._('getBlock');
  static const SolanaRequestMethods getBlockCommitment =
      SolanaRequestMethods._('getBlockCommitment');
  static const SolanaRequestMethods getBlockHeight =
      SolanaRequestMethods._('getBlockHeight');
  static const SolanaRequestMethods getBlockProduction =
      SolanaRequestMethods._('getBlockProduction');
  static const SolanaRequestMethods getBlockTime =
      SolanaRequestMethods._('getBlockTime');
  static const SolanaRequestMethods getBlocks =
      SolanaRequestMethods._('getBlocks');
  static const SolanaRequestMethods getBlocksWithLimit =
      SolanaRequestMethods._('getBlocksWithLimit');
  static const SolanaRequestMethods getClusterNodes =
      SolanaRequestMethods._('getClusterNodes');
  static const SolanaRequestMethods getEpochInfo =
      SolanaRequestMethods._('getEpochInfo');
  static const SolanaRequestMethods getEpochSchedule =
      SolanaRequestMethods._('getEpochSchedule');
  static const SolanaRequestMethods getFeeForMessage =
      SolanaRequestMethods._('getFeeForMessage');
  static const SolanaRequestMethods getFirstAvailableBlock =
      SolanaRequestMethods._('getFirstAvailableBlock');
  static const SolanaRequestMethods getGenesisHash =
      SolanaRequestMethods._('getGenesisHash');
  static const SolanaRequestMethods getHealth =
      SolanaRequestMethods._('getHealth');
  static const SolanaRequestMethods getHighestSnapshotSlot =
      SolanaRequestMethods._('getHighestSnapshotSlot');
  static const SolanaRequestMethods getIdentity =
      SolanaRequestMethods._('getIdentity');
  static const SolanaRequestMethods getInflationGovernor =
      SolanaRequestMethods._('getInflationGovernor');
  static const SolanaRequestMethods getInflationRate =
      SolanaRequestMethods._('getInflationRate');
  static const SolanaRequestMethods getInflationReward =
      SolanaRequestMethods._('getInflationReward');
  static const SolanaRequestMethods getLargestAccounts =
      SolanaRequestMethods._('getLargestAccounts');
  static const SolanaRequestMethods getLeaderSchedule =
      SolanaRequestMethods._('getLeaderSchedule');
  static const SolanaRequestMethods getMaxRetransmitSlot =
      SolanaRequestMethods._('getMaxRetransmitSlot');
  static const SolanaRequestMethods getMaxShredInsertSlot =
      SolanaRequestMethods._('getMaxShredInsertSlot');
  static const SolanaRequestMethods getMultipleAccounts =
      SolanaRequestMethods._('getMultipleAccounts');
  static const SolanaRequestMethods getRecentPerformanceSamples =
      SolanaRequestMethods._('getRecentPerformanceSamples');
  static const SolanaRequestMethods getRecentPrioritizationFees =
      SolanaRequestMethods._('getRecentPrioritizationFees');
  static const SolanaRequestMethods getSignatureStatuses =
      SolanaRequestMethods._('getSignatureStatuses');
  static const SolanaRequestMethods getSlot = SolanaRequestMethods._('getSlot');
  static const SolanaRequestMethods getSlotLeader =
      SolanaRequestMethods._('getSlotLeader');
  static const SolanaRequestMethods getSlotLeaders =
      SolanaRequestMethods._('getSlotLeaders');
  static const SolanaRequestMethods getStakeActivation =
      SolanaRequestMethods._('getStakeActivation');
  static const SolanaRequestMethods getStakeMinimumDelegation =
      SolanaRequestMethods._('getStakeMinimumDelegation');
  static const SolanaRequestMethods getSupply =
      SolanaRequestMethods._('getSupply');
  static const SolanaRequestMethods getTokenAccountBalance =
      SolanaRequestMethods._('getTokenAccountBalance');
  static const SolanaRequestMethods getTokenAccountsByDelegate =
      SolanaRequestMethods._('getTokenAccountsByDelegate');
  static const SolanaRequestMethods getTokenAccountsByOwner =
      SolanaRequestMethods._('getTokenAccountsByOwner');
  static const SolanaRequestMethods getTokenLargestAccounts =
      SolanaRequestMethods._('getTokenLargestAccounts');
  static const SolanaRequestMethods getTokenSupply =
      SolanaRequestMethods._('getTokenSupply');
  static const SolanaRequestMethods getTransactionCount =
      SolanaRequestMethods._('getTransactionCount');
  static const SolanaRequestMethods getVersion =
      SolanaRequestMethods._('getVersion');
  static const SolanaRequestMethods getVoteAccounts =
      SolanaRequestMethods._('getVoteAccounts');
  static const SolanaRequestMethods isBlockhashValid =
      SolanaRequestMethods._('isBlockhashValid');
  static const SolanaRequestMethods minimumLedgerSlot =
      SolanaRequestMethods._('minimumLedgerSlot');
  static const SolanaRequestMethods requestAirdrop =
      SolanaRequestMethods._('requestAirdrop');
}
