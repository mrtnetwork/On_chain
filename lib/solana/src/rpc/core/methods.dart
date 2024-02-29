/// A class containing constants representing various Solana RPC methods.
class SolanaRPCMethods {
  final String value;

  /// Constructs a [SolanaRPCMethods] instance with a specific value.
  const SolanaRPCMethods._(this.value);

  static const SolanaRPCMethods getLatestBlockhash =
      SolanaRPCMethods._("getLatestBlockhash");
  static const SolanaRPCMethods getMinimumBalanceForRentExemption =
      SolanaRPCMethods._("getMinimumBalanceForRentExemption");
  static const SolanaRPCMethods sendTransaction =
      SolanaRPCMethods._("sendTransaction");
  static const SolanaRPCMethods simulateTransaction =
      SolanaRPCMethods._("simulateTransaction");
  static const SolanaRPCMethods getBalance = SolanaRPCMethods._("getBalance");
  static const SolanaRPCMethods getProgramAccounts =
      SolanaRPCMethods._("getProgramAccounts");
  static const SolanaRPCMethods getSignaturesForAddress =
      SolanaRPCMethods._("getSignaturesForAddress");
  static const SolanaRPCMethods getTransaction =
      SolanaRPCMethods._("getTransaction");
  static const SolanaRPCMethods getAccountInfo =
      SolanaRPCMethods._("getAccountInfo");
  static const SolanaRPCMethods getBlock = SolanaRPCMethods._("getBlock");
  static const SolanaRPCMethods getBlockCommitment =
      SolanaRPCMethods._("getBlockCommitment");
  static const SolanaRPCMethods getBlockHeight =
      SolanaRPCMethods._("getBlockHeight");
  static const SolanaRPCMethods getBlockProduction =
      SolanaRPCMethods._("getBlockProduction");
  static const SolanaRPCMethods getBlockTime =
      SolanaRPCMethods._("getBlockTime");
  static const SolanaRPCMethods getBlocks = SolanaRPCMethods._("getBlocks");
  static const SolanaRPCMethods getBlocksWithLimit =
      SolanaRPCMethods._("getBlocksWithLimit");
  static const SolanaRPCMethods getClusterNodes =
      SolanaRPCMethods._("getClusterNodes");
  static const SolanaRPCMethods getEpochInfo =
      SolanaRPCMethods._("getEpochInfo");
  static const SolanaRPCMethods getEpochSchedule =
      SolanaRPCMethods._("getEpochSchedule");
  static const SolanaRPCMethods getFeeForMessage =
      SolanaRPCMethods._("getFeeForMessage");
  static const SolanaRPCMethods getFirstAvailableBlock =
      SolanaRPCMethods._("getFirstAvailableBlock");
  static const SolanaRPCMethods getGenesisHash =
      SolanaRPCMethods._("getGenesisHash");
  static const SolanaRPCMethods getHealth = SolanaRPCMethods._("getHealth");
  static const SolanaRPCMethods getHighestSnapshotSlot =
      SolanaRPCMethods._("getHighestSnapshotSlot");
  static const SolanaRPCMethods getIdentity = SolanaRPCMethods._("getIdentity");
  static const SolanaRPCMethods getInflationGovernor =
      SolanaRPCMethods._("getInflationGovernor");
  static const SolanaRPCMethods getInflationRate =
      SolanaRPCMethods._("getInflationRate");
  static const SolanaRPCMethods getInflationReward =
      SolanaRPCMethods._("getInflationReward");
  static const SolanaRPCMethods getLargestAccounts =
      SolanaRPCMethods._("getLargestAccounts");
  static const SolanaRPCMethods getLeaderSchedule =
      SolanaRPCMethods._("getLeaderSchedule");
  static const SolanaRPCMethods getMaxRetransmitSlot =
      SolanaRPCMethods._("getMaxRetransmitSlot");
  static const SolanaRPCMethods getMaxShredInsertSlot =
      SolanaRPCMethods._("getMaxShredInsertSlot");
  static const SolanaRPCMethods getMultipleAccounts =
      SolanaRPCMethods._("getMultipleAccounts");
  static const SolanaRPCMethods getRecentPerformanceSamples =
      SolanaRPCMethods._("getRecentPerformanceSamples");
  static const SolanaRPCMethods getRecentPrioritizationFees =
      SolanaRPCMethods._("getRecentPrioritizationFees");
  static const SolanaRPCMethods getSignatureStatuses =
      SolanaRPCMethods._("getSignatureStatuses");
  static const SolanaRPCMethods getSlot = SolanaRPCMethods._("getSlot");
  static const SolanaRPCMethods getSlotLeader =
      SolanaRPCMethods._("getSlotLeader");
  static const SolanaRPCMethods getSlotLeaders =
      SolanaRPCMethods._("getSlotLeaders");
  static const SolanaRPCMethods getStakeActivation =
      SolanaRPCMethods._("getStakeActivation");
  static const SolanaRPCMethods getStakeMinimumDelegation =
      SolanaRPCMethods._("getStakeMinimumDelegation");
  static const SolanaRPCMethods getSupply = SolanaRPCMethods._("getSupply");
  static const SolanaRPCMethods getTokenAccountBalance =
      SolanaRPCMethods._("getTokenAccountBalance");
  static const SolanaRPCMethods getTokenAccountsByDelegate =
      SolanaRPCMethods._("getTokenAccountsByDelegate");
  static const SolanaRPCMethods getTokenAccountsByOwner =
      SolanaRPCMethods._("getTokenAccountsByOwner");
  static const SolanaRPCMethods getTokenLargestAccounts =
      SolanaRPCMethods._("getTokenLargestAccounts");
  static const SolanaRPCMethods getTokenSupply =
      SolanaRPCMethods._("getTokenSupply");
  static const SolanaRPCMethods getTransactionCount =
      SolanaRPCMethods._("getTransactionCount");
  static const SolanaRPCMethods getVersion = SolanaRPCMethods._("getVersion");
  static const SolanaRPCMethods getVoteAccounts =
      SolanaRPCMethods._("getVoteAccounts");
  static const SolanaRPCMethods isBlockhashValid =
      SolanaRPCMethods._("isBlockhashValid");
  static const SolanaRPCMethods minimumLedgerSlot =
      SolanaRPCMethods._("minimumLedgerSlot");
  static const SolanaRPCMethods requestAirdrop =
      SolanaRPCMethods._("requestAirdrop");
}
