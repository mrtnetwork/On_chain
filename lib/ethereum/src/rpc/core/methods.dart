/// Represents Ethereum JSON-RPC methods.
class EthereumMethods {
  final String value;

  /// The string value of the method.
  const EthereumMethods(this.value);

  static const EthereumMethods getProtocolVersion =
      EthereumMethods('eth_protocolVersion');
  static const EthereumMethods subscribe = EthereumMethods('eth_subscribe');
  static const EthereumMethods getSyncing = EthereumMethods('eth_syncing');
  static const EthereumMethods getCoinbase = EthereumMethods('eth_coinbase');
  static const EthereumMethods getMining = EthereumMethods('eth_mining');
  static const EthereumMethods getHashRate = EthereumMethods('eth_hashrate');
  static const EthereumMethods getGasPrice = EthereumMethods('eth_gasPrice');
  static const EthereumMethods getAccounts = EthereumMethods('eth_accounts');
  static const EthereumMethods getBlockNumber =
      EthereumMethods('eth_blockNumber');
  static const EthereumMethods getBalance = EthereumMethods('eth_getBalance');
  static const EthereumMethods getStorageAt =
      EthereumMethods('eth_getStorageAt');
  static const EthereumMethods getTransactionCount =
      EthereumMethods('eth_getTransactionCount');
  static const EthereumMethods getBlockTransactionCountByHash =
      EthereumMethods('eth_getBlockTransactionCountByHash');
  static const EthereumMethods getBlockTransactionCountByNumber =
      EthereumMethods('eth_getBlockTransactionCountByNumber');
  static const EthereumMethods getUncleCountByBlockHash =
      EthereumMethods('eth_getUncleCountByBlockHash');
  static const EthereumMethods getUncleCountByBlockNumber =
      EthereumMethods('eth_getUncleCountByBlockNumber');
  static const EthereumMethods getCode = EthereumMethods('eth_getCode');
  static const EthereumMethods sign = EthereumMethods('eth_sign');
  static const EthereumMethods signTransaction =
      EthereumMethods('eth_signTransaction');
  static const EthereumMethods ethSubscribe = EthereumMethods('eth_subscribe');
  static const EthereumMethods ethUnsubscribe =
      EthereumMethods('eth_unsubscribe');
  static const EthereumMethods sendTransaction =
      EthereumMethods('eth_sendTransaction');
  static const EthereumMethods sendRawTransaction =
      EthereumMethods('eth_sendRawTransaction');
  static const EthereumMethods call = EthereumMethods('eth_call');
  static const EthereumMethods estimateGas = EthereumMethods('eth_estimateGas');
  static const EthereumMethods getBlockByHash =
      EthereumMethods('eth_getBlockByHash');

  static const EthereumMethods getBlockByNumber =
      EthereumMethods('eth_getBlockByNumber');
  static const EthereumMethods getTransactionByHash =
      EthereumMethods('eth_getTransactionByHash');
  static const EthereumMethods getTransactionByBlockHashAndIndex =
      EthereumMethods('eth_getTransactionByBlockHashAndIndex');

  static const EthereumMethods getTransactionByBlockNumberAndIndex =
      EthereumMethods('eth_getTransactionByBlockNumberAndIndex');
  static const EthereumMethods getTransactionReceipt =
      EthereumMethods('eth_getTransactionReceipt');

  static const EthereumMethods getUncleByBlockHashAndIndex =
      EthereumMethods('eth_getUncleByBlockHashAndIndex');
  static const EthereumMethods getUncleByBlockNumberAndIndex =
      EthereumMethods('eth_getUncleByBlockNumberAndIndex');
  static const EthereumMethods getCompilers =
      EthereumMethods('eth_getCompilers');

  static const EthereumMethods compileSolidity =
      EthereumMethods('eth_compileSolidity');
  static const EthereumMethods compileLLL = EthereumMethods('eth_compileLLL');
  static const EthereumMethods compileSerpent =
      EthereumMethods('eth_compileSerpent');
  static const EthereumMethods newFilter = EthereumMethods('eth_newFilter');

  static const EthereumMethods newBlockFilter =
      EthereumMethods('eth_newBlockFilter');
  static const EthereumMethods newPendingTransactionFilter =
      EthereumMethods('eth_newPendingTransactionFilter');
  static const EthereumMethods uninstallFilter =
      EthereumMethods('eth_uninstallFilter');
  static const EthereumMethods getFilterChanges =
      EthereumMethods('eth_getFilterChanges');

  static const EthereumMethods getFilterLogs =
      EthereumMethods('eth_getFilterLogs');
  static const EthereumMethods getLogs = EthereumMethods('eth_getLogs');
  static const EthereumMethods getWork = EthereumMethods('eth_getWork');
  static const EthereumMethods submitWork = EthereumMethods('eth_submitWork');
  static const EthereumMethods submitHashrate =
      EthereumMethods('eth_submitHashrate');
  static const EthereumMethods getFeeHistory =
      EthereumMethods('eth_feeHistory');
  static const EthereumMethods getPendingTransactions =
      EthereumMethods('eth_pendingTransactions');
  static const EthereumMethods requestAccounts =
      EthereumMethods('eth_requestAccounts');
  static const EthereumMethods getChainId = EthereumMethods('eth_chainId');
  static const EthereumMethods getProof = EthereumMethods('eth_getProof');
  static const EthereumMethods getNodeInfo =
      EthereumMethods('web3_clientVersion');
  static const EthereumMethods createAccessList =
      EthereumMethods('eth_createAccessList');
  static const EthereumMethods signTypedData =
      EthereumMethods('eth_signTypedData');
  static const EthereumMethods netVersion = EthereumMethods('net_version');

  static const List<EthereumMethods> values = [
    netVersion,
    signTypedData,
    createAccessList,
    getNodeInfo,
    getProtocolVersion,
    subscribe,
    getSyncing,
    getCoinbase,
    getMining,
    getHashRate,
    getGasPrice,
    getAccounts,
    getBlockNumber,
    getBalance,
    getStorageAt,
    getTransactionCount,
    getBlockTransactionCountByHash,
    getBlockTransactionCountByNumber,
    getUncleCountByBlockHash,
    getUncleCountByBlockNumber,
    getCode,
    sign,
    signTransaction,
    sendTransaction,
    sendRawTransaction,
    call,
    estimateGas,
    getBlockByHash,
    getBlockByNumber,
    getTransactionByHash,
    getTransactionByBlockHashAndIndex,
    getTransactionByBlockNumberAndIndex,
    getTransactionReceipt,
    getUncleByBlockHashAndIndex,
    getUncleByBlockNumberAndIndex,
    getCompilers,
    compileSolidity,
    compileLLL,
    compileSerpent,
    newFilter,
    newBlockFilter,
    newPendingTransactionFilter,
    uninstallFilter,
    getFilterChanges,
    getFilterLogs,
    getLogs,
    getWork,
    submitWork,
    submitHashrate,
    getFeeHistory,
    getPendingTransactions,
    requestAccounts,
    getChainId,
    getProof,
    getNodeInfo
  ];

  static EthereumMethods? fromName(String? name) {
    try {
      return values.firstWhere((e) => e.value == name);
    } on StateError {
      return null;
    }
  }
}
