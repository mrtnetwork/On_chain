class BlockfrostMethods {
  final String name;
  final String url;
  const BlockfrostMethods._(this.name, this.url);

  /// Root endpoint has no other function than to point end users to documentation.
  static const BlockfrostMethods rootEndpoint =
      BlockfrostMethods._("Root endpoint", "/");

  /// Return backend status as a boolean. Your application should handle situations
  /// when backend for the given chain is unavailable.
  static const BlockfrostMethods backendHealthStatus =
      BlockfrostMethods._("Backend health status", "/health");

  /// This endpoint provides the current UNIX time. Your application
  /// might use this to verify if the client clock is not out of sync.
  static const BlockfrostMethods currentBackendTime =
      BlockfrostMethods._("Current backend time", "/health/clock");

  /// History of your Blockfrost usage metrics in the past 30 days.
  static const BlockfrostMethods blockFrostUsageMetric =
      BlockfrostMethods._("Blockfrost usage metrics", "/metrics");

  /// History of your Blockfrost usage metrics per endpoint in the past 30 days.
  static const BlockfrostMethods blockFrostEndpointUsageMetrics =
      BlockfrostMethods._(
          "Blockfrost endpoint usage metrics", "/metrics/endpoints");

  /// Obtain information about a specific stake account.
  static const BlockfrostMethods specificAccountAddress = BlockfrostMethods._(
      "Specific account address", "/accounts/:stake_address");

  /// Obtain information about the reward history of a specific account.
  static const BlockfrostMethods accountRewardHistory = BlockfrostMethods._(
      "Account reward history", "/accounts/:stake_address/rewards");

  /// Obtain information about the history of a specific account.
  static const BlockfrostMethods accountHistory = BlockfrostMethods._(
      "Account history", "/accounts/:stake_address/history");

  /// Obtain information about the delegation of a specific account.
  static const BlockfrostMethods accountDelegationHistory = BlockfrostMethods._(
      "Account delegation history", "/accounts/:stake_address/delegations");

  /// Obtain information about the registrations and deregistrations of a specific account.
  static const BlockfrostMethods accountRegistrationHistory =
      BlockfrostMethods._("Account registration history",
          "/accounts/:stake_address/registrations");

  /// Obtain information about the withdrawals of a specific account.
  static const BlockfrostMethods accountWithdrawalHistory = BlockfrostMethods._(
      "Account withdrawal history", "/accounts/:stake_address/withdrawals");

  /// Obtain information about the MIRs of a specific account.
  static const BlockfrostMethods accountMIRHistory = BlockfrostMethods._(
      "Account MIR history", "/accounts/:stake_address/mirs");

  /// Obtain information about the addresses of a specific account.
  static const BlockfrostMethods accountAssociatedAddresses =
      BlockfrostMethods._(
          "Account associated addresses", "/accounts/:stake_address/addresses");

  /// Obtain information about assets associated with addresses of a specific account.
  static const BlockfrostMethods assetsAssociatedWithTheAccountAddresses =
      BlockfrostMethods._("Assets associated with the account addresses",
          "/accounts/:stake_address/addresses/assets");

  /// Obtain summed details about all addresses associated with a given account.
  static const BlockfrostMethods
      detailedInformationAboutAccountAssociatedAddresses = BlockfrostMethods._(
          "Detailed information about account associated addresses",
          "/accounts/:stake_address/addresses/total");

  /// Obtain information about a specific address.
  static const BlockfrostMethods specificAddress =
      BlockfrostMethods._("Specific address", "/addresses/:address");

  /// Obtain extended information about a specific address.
  static const BlockfrostMethods extendedInformationOfaSpecificAddress =
      BlockfrostMethods._("Extended information of a specific address",
          "/addresses/:address/extended");

  /// Obtain details about an address.
  static const BlockfrostMethods addressDetails =
      BlockfrostMethods._("Address details", "/addresses/:address/total");

  /// UTXOs of the address.
  static const BlockfrostMethods addressUTXOs =
      BlockfrostMethods._("Address UTXOs", "/addresses/:address/utxos");

  /// UTXOs of the address.
  static const BlockfrostMethods addressUTXOsOfaGivenAsset =
      BlockfrostMethods._(
          "Address UTXOs of a given asset", "/addresses/:address/utxos/:asset");

  /// Transactions on the address.
  static const BlockfrostMethods addressTransactions = BlockfrostMethods._(
      "Address transactions", "/addresses/:address/transactions");

  /// List of assets. If an asset is completely burned, it will stay on the list with quantity 0 (order of assets is immutable
  static const BlockfrostMethods assets =
      BlockfrostMethods._("Assets", "/assets");

  /// Information about a specific asset.
  static const BlockfrostMethods specificAsset =
      BlockfrostMethods._("Specific asset", "/assets/:asset");

  /// History of a specific asset.
  static const BlockfrostMethods assetHistory =
      BlockfrostMethods._("Asset history", "/assets/:asset/history");

  /// List of a specific asset transactions.
  static const BlockfrostMethods assetTransactions =
      BlockfrostMethods._("Asset transactions", "/assets/:asset/transactions");

  /// List of a addresses containing a specific asset.
  static const BlockfrostMethods assetAddresses =
      BlockfrostMethods._("Asset addresses", "/assets/:asset/addresses");

  /// List of asset minted under a specific policy.
  static const BlockfrostMethods assetsOfaSpecificPolicy = BlockfrostMethods._(
      "Assets of a specific policy", "/assets/policy/:policy_id");

  /// Return the latest block available to the backends, also known as the tip of the blockchain.
  static const BlockfrostMethods latestBlock =
      BlockfrostMethods._("Latest block", "/blocks/latest");

  /// Return the transactions within the latest block.
  static const BlockfrostMethods lastBlockTransactions =
      BlockfrostMethods._("Latest block transactions", "/blocks/latest/txs");

  /// Return the content of a requested block.
  static const BlockfrostMethods specificBlock =
      BlockfrostMethods._("Specific block", "/blocks/:hash_or_number");

  /// Return the list of blocks following a specific block.
  static const BlockfrostMethods listingOfNextBlocks = BlockfrostMethods._(
      "Listing of next blocks", "/blocks/:hash_or_number/next");

  /// Return the list of blocks preceding a specific block.
  static const BlockfrostMethods listingOfPreviousBlocks = BlockfrostMethods._(
      "Listing of previous blocks", "/blocks/:hash_or_number/previous");

  /// Return the content of a requested block for a specific slot.
  static const BlockfrostMethods specificBlockInASlot = BlockfrostMethods._(
      "Specific block in a slot", "/blocks/slot/:slot_number");

  /// Return the content of a requested block for a specific slot in an epoch.
  static const BlockfrostMethods specificBlockInASlotInAnEpoch =
      BlockfrostMethods._("Specific block in a slot in an epoch",
          "/blocks/epoch/:epoch_number/slot/:slot_number");

  /// Return the transactions within the block.
  static const BlockfrostMethods blockTransactions =
      BlockfrostMethods._("Block transactions", "/blocks/:hash_or_number/txs");

  /// Return list of addresses affected in the specified block with additional information, sorted by the bech32 address, ascending.
  static const BlockfrostMethods addressesAffectedInASpecificBlock =
      BlockfrostMethods._("Addresses affected in a specific block",
          "/blocks/:hash_or_number/addresses");

  /// Return the information about the latest, therefore current, epoch..
  static const BlockfrostMethods latestEpoch =
      BlockfrostMethods._("Latest epoch", "/epochs/latest");

  /// Return the protocol parameters for the latest epoch..
  static const BlockfrostMethods latestEpochProtocolParameters =
      BlockfrostMethods._(
          "Latest epoch protocol parameters", "/epochs/latest/parameters");

  /// Return the content of the requested epoch.
  static const BlockfrostMethods specificEpoch =
      BlockfrostMethods._("Specific epoch", "/epochs/:number");

  /// Return the list of epochs following a specific epoch.
  static const BlockfrostMethods listingOfNextEpoches =
      BlockfrostMethods._("Listing of next epochs", "/epochs/:number/next");

  /// Return the list of epochs preceding a specific epoch.
  static const BlockfrostMethods listingOfPreviousEpoches = BlockfrostMethods._(
      "Listing of previous epochs", "/epochs/:number/previous");

  /// Return the active stake distribution for the specified epoch.
  static const BlockfrostMethods stakeDistribution =
      BlockfrostMethods._("Stake distribution", "/epochs/:number/stakes");

  /// Return the active stake distribution for the epoch specified by stake pool.
  static const BlockfrostMethods stakeDistributionByPool = BlockfrostMethods._(
      "Stake distribution by pool", "/epochs/:number/stakes/:pool_id");

  /// Return the blocks minted for the epoch specified.
  static const BlockfrostMethods blockDistribution =
      BlockfrostMethods._("Block distribution", "/epochs/:number/blocks");

  /// Return the block minted for the epoch specified by stake pool.
  static const BlockfrostMethods blockDistributionByPool = BlockfrostMethods._(
      "Block distribution by pool", "/epochs/:number/blocks/:pool_id");

  /// Return the protocol parameters for the epoch specified.
  static const BlockfrostMethods protocolParameters =
      BlockfrostMethods._("Protocol parameters", "/epochs/:number/parameters");

  /// Return the information about blockchain genesis.
  static const BlockfrostMethods blockchainGenesis =
      BlockfrostMethods._("Blockchain genesis", "/genesis");

  /// Return transactions that are currently stored in Blockfrost mempool,
  /// waiting to be included in a newly minted block.
  /// Shows only transactions submitted via Blockfrost.io.
  static const BlockfrostMethods mempool =
      BlockfrostMethods._("Mempool", "/mempool");

  /// Return content of the requested transaction.
  static const BlockfrostMethods specificTransactionInTheMempool =
      BlockfrostMethods._(
          "Specific transaction in the mempool", "/mempool/:hash");

  /// List of mempool transactions where at least one of the transaction
  /// inputs or outputs belongs to the address. Shows only transactions
  /// submitted via Blockfrost.io.
  static const BlockfrostMethods mempoolByAddress =
      BlockfrostMethods._("Mempool by address", "/mempool/addresses/:address");

  /// List of all used transaction metadata labels.
  static const BlockfrostMethods transactionMetadataLabels =
      BlockfrostMethods._(
          "Transaction metadata labels", "/metadata/txs/labels");

  /// Transaction metadata per label.
  static const BlockfrostMethods transactionMetadataContentInJson =
      BlockfrostMethods._("Transaction metadata content in JSON",
          "/metadata/txs/labels/:label");

  /// Transaction metadata per label.
  static const BlockfrostMethods transactionMetadataContentInCbor =
      BlockfrostMethods._("Transaction metadata content in CBOR",
          "/metadata/txs/labels/:label/cbor");

  /// Return detailed network information.
  static const BlockfrostMethods networkInformation =
      BlockfrostMethods._("Network information", "/network");

  /// Returns start and end of each era along with parameters that can vary between hard forks.
  static const BlockfrostMethods querySummaryOfBlockchainEras =
      BlockfrostMethods._("Query summary of blockchain eras", "/network/eras");

  /// List of registered stake pools.
  static const BlockfrostMethods listOfStakePools =
      BlockfrostMethods._("List of stake pools", "/pools");

  /// List of registered stake pools with additional information.
  static const BlockfrostMethods listOfStakePoolsWithAdditionalInformation =
      BlockfrostMethods._(
          "List of stake pools with additional information", "/pools/extended");

  /// List of already retired pools.
  static const BlockfrostMethods listOfRetiredStakePools =
      BlockfrostMethods._("List of retired stake pools", "/pools/retired");

  /// List of stake pools retiring in the upcoming epochs.
  static const BlockfrostMethods listOfRetiringStakePools =
      BlockfrostMethods._("List of retiring stake pools", "/pools/retiring");

  /// Pool information.
  static const BlockfrostMethods specificStakePool =
      BlockfrostMethods._("Specific stake pool", "/pools/:pool_id");

  /// History of stake pool parameters over epochs.
  static const BlockfrostMethods stakePoolHistory =
      BlockfrostMethods._("Stake pool history", "/pools/:pool_id/history");

  /// Stake pool registration metadata.
  static const BlockfrostMethods stakePoolMetadata =
      BlockfrostMethods._("Stake pool metadata", "/pools/:pool_id/metadata");

  /// Relays of a stake pool.
  static const BlockfrostMethods stakePoolRelays =
      BlockfrostMethods._("Stake pool relays", "/pools/:pool_id/relays");

  /// List of current stake pools delegators.
  static const BlockfrostMethods stakePoolDelegators = BlockfrostMethods._(
      "Stake pool delegators", "/pools/:pool_id/delegators");

  /// List of stake pools blocks.
  static const BlockfrostMethods stakePoolBlocks =
      BlockfrostMethods._("Stake pool blocks", "/pools/:pool_id/blocks");

  /// List of certificate updates to the stake pool.
  static const BlockfrostMethods stakePoolUpdates =
      BlockfrostMethods._("Stake pool updates", "/pools/:pool_id/updates");

  /// List of scripts.
  static const BlockfrostMethods scripts =
      BlockfrostMethods._("Scripts", "/scripts");

  /// Information about a specific script.
  static const BlockfrostMethods specificScript =
      BlockfrostMethods._("Specific script", "/scripts/:script_hash");

  /// JSON representation of a timelock script
  static const BlockfrostMethods scriptJson =
      BlockfrostMethods._("Script JSON", "/scripts/:script_hash/json");

  /// CBOR representation of a plutus script.
  static const BlockfrostMethods scriptCBOR =
      BlockfrostMethods._("Script CBOR", "/scripts/:script_hash/cbor");

  /// List of redeemers of a specific script.
  static const BlockfrostMethods redeemersOfASpecificScript =
      BlockfrostMethods._(
          "Redeemers of a specific script", "/scripts/:script_hash/redeemers");

  /// Query JSON value of a datum by its hash.
  static const BlockfrostMethods datumValue =
      BlockfrostMethods._("Datum value", "/scripts/datum/:datum_hash");

  /// Query CBOR serialised datum by its hash.
  static const BlockfrostMethods dataumCBORValue = BlockfrostMethods._(
      "Datum CBOR value", "/scripts/datum/:datum_hash/cbor");

  /// Return content of the requested transaction.
  static const BlockfrostMethods specificTransaction =
      BlockfrostMethods._("Specific transaction", "/txs/:hash");

  /// Return the inputs and UTXOs of the specific transaction.
  static const BlockfrostMethods transactionUTXOs =
      BlockfrostMethods._("Transaction UTXOs", "/txs/:hash/utxos");

  /// Obtain information about (de)registration of stake addresses within a transaction.
  static const BlockfrostMethods transactionStakeAddressesCertificates =
      BlockfrostMethods._(
          "Transaction stake addresses certificates", "/txs/:hash/stakes");

  /// Obtain information about delegation certificates of a specific transaction.
  static const BlockfrostMethods transactionDelegationCertificates =
      BlockfrostMethods._(
          "Transaction delegation certificates", "/txs/:hash/delegations");

  /// Obtain information about withdrawals of a specific transaction.
  static const BlockfrostMethods transactionWithdrawal =
      BlockfrostMethods._("Transaction withdrawal", "/txs/:hash/withdrawals");

  /// Obtain information about Move Instantaneous Rewards (MIRs) of a specific transaction.
  static const BlockfrostMethods transactionMIRs =
      BlockfrostMethods._("Transaction MIRs", "/txs/:hash/mirs");

  /// Obtain information about stake pool registration and update certificates of a specific transaction.
  static const BlockfrostMethods
      transactionStakePoolRegistrationAndUpdateCertificates =
      BlockfrostMethods._(
          "Transaction stake pool registration and update certificates",
          "/txs/:hash/pool_updates");

  /// Obtain information about stake pool retirements within a specific transaction.
  static const BlockfrostMethods transactionStakePoolRetirementCertificates =
      BlockfrostMethods._("Transaction stake pool retirement certificates",
          "/txs/:hash/pool_retires");

  /// Obtain the transaction metadata.
  static const BlockfrostMethods transactionMetadata =
      BlockfrostMethods._("Transaction metadata", "/txs/:hash/metadata");

  /// Obtain the transaction metadata in CBOR.
  static const BlockfrostMethods transactionMetadataInCBOR =
      BlockfrostMethods._(
          "Transaction metadata in CBOR", "/txs/:hash/metadata/cbor");

  /// Obtain the transaction redeemers.
  static const BlockfrostMethods transactionRedeemers =
      BlockfrostMethods._("Transaction redeemers", "/txs/:hash/redeemers");

  /// Submit an already serialized transaction to the network.
  static const BlockfrostMethods submitTransaction =
      BlockfrostMethods._("Submit a transaction", "/tx/submit");

  /// Derive Shelley address from an xpub
  static const BlockfrostMethods deriveAnAddress = BlockfrostMethods._(
      "Derive an address", "/utils/addresses/xpub/:xpub/:role/:index");

  /// Submit an already serialized transaction to evaluate how much execution units it requires.
  static const BlockfrostMethods submitATransactionForExecutionUnitsEvaluation =
      BlockfrostMethods._("Submit a transaction for execution units evaluation",
          "/utils/txs/evaluate");

  /// Submit a JSON payload with transaction CBOR and additional UTXO set to evaluate how much execution units it requires.
  static const BlockfrostMethods
      submitATransactionForExecutionUnitsEvaluationAdditionalUTXOset =
      BlockfrostMethods._(
          "Submit a transaction for execution units evaluation (additional UTXO set)",
          "/utils/txs/evaluate/utxos");

  /// List metadata about specific address
  static const BlockfrostMethods specificNutlinkAddress =
      BlockfrostMethods._("Specific nut.link address", "/nutlink/:address");

  /// List of records of a specific oracle
  static const BlockfrostMethods listOfTickersOfAnOracle = BlockfrostMethods._(
      "List of tickers of an oracle", "/nutlink/:address/tickers");

  /// List of records of a specific ticker
  static const BlockfrostMethods specificTickerForAnAddress = BlockfrostMethods
      ._("Specific ticker for an address", "/nutlink/:address/tickers/:ticker");

  /// List of records of a specific ticker
  static const BlockfrostMethods specificTicker =
      BlockfrostMethods._("Specific ticker", "/nutlink/tickers/:ticker");

  static const List<BlockfrostMethods> values = [
    rootEndpoint,
    blockFrostUsageMetric,
    blockFrostEndpointUsageMetrics,
    backendHealthStatus,
    currentBackendTime,
    specificNutlinkAddress,
    specificTickerForAnAddress,
    listOfTickersOfAnOracle,
    specificTicker,
    specificAccountAddress,
    accountRewardHistory,
    accountHistory,
    accountDelegationHistory,
    accountRegistrationHistory,
    accountWithdrawalHistory,
    accountMIRHistory,
    accountAssociatedAddresses,
    assetsAssociatedWithTheAccountAddresses,
    detailedInformationAboutAccountAssociatedAddresses,
    specificAddress,
    extendedInformationOfaSpecificAddress,
    addressDetails,
    addressUTXOs,
    addressUTXOsOfaGivenAsset,
    addressTransactions,
    assets,
    specificAsset,
    assetHistory,
    assetTransactions,
    assetAddresses,
    assetsOfaSpecificPolicy,
    latestBlock,
    lastBlockTransactions,
    specificBlock,
    listingOfNextBlocks,
    listingOfPreviousBlocks,
    specificBlockInASlot,
    specificBlockInASlotInAnEpoch,
    blockTransactions,
    addressesAffectedInASpecificBlock,
    latestEpoch,
    latestEpochProtocolParameters,
    specificEpoch,
    listingOfNextEpoches,
    listingOfPreviousEpoches,
    stakeDistribution,
    stakeDistributionByPool,
    blockDistribution,
    blockDistributionByPool,
    protocolParameters,
    blockchainGenesis,
    mempool,
    specificTransactionInTheMempool,
    mempoolByAddress,
    transactionMetadataLabels,
    transactionMetadataContentInJson,
    transactionMetadataContentInCbor,
    networkInformation,
    querySummaryOfBlockchainEras,
    listOfStakePools,
    listOfStakePoolsWithAdditionalInformation,
    listOfRetiredStakePools,
    listOfRetiringStakePools,
    specificStakePool,
    stakePoolHistory,
    stakePoolMetadata,
    stakePoolRelays,
    stakePoolDelegators,
    stakePoolBlocks,
    stakePoolUpdates,
    scripts,
    specificScript,
    scriptJson,
    scriptCBOR,
    redeemersOfASpecificScript,
    datumValue,
    dataumCBORValue,
    specificTransaction,
    transactionUTXOs,
    transactionStakeAddressesCertificates,
    transactionDelegationCertificates,
    transactionWithdrawal,
    transactionMIRs,
    transactionStakePoolRegistrationAndUpdateCertificates,
    transactionStakePoolRetirementCertificates,
    transactionMetadata,
    transactionMetadataInCBOR,
    transactionRedeemers,
    submitTransaction,
    deriveAnAddress,
    submitATransactionForExecutionUnitsEvaluation,
    submitATransactionForExecutionUnitsEvaluationAdditionalUTXOset,
  ];
}
