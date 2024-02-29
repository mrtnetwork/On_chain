/// Represents Ethereum JSON-RPC methods.
class EthereumMethods {
  final String value;

  /// The string value of the method.
  const EthereumMethods._(this.value);

  static const EthereumMethods getProtocolVersion =
      EthereumMethods._('eth_protocolVersion');
  static const EthereumMethods subscribe = EthereumMethods._('eth_subscribe');
  static const EthereumMethods getSyncing = EthereumMethods._('eth_syncing');
  static const EthereumMethods getCoinbase = EthereumMethods._('eth_coinbase');
  static const EthereumMethods getMining = EthereumMethods._('eth_mining');
  static const EthereumMethods getHashRate = EthereumMethods._('eth_hashrate');
  static const EthereumMethods getGasPrice = EthereumMethods._('eth_gasPrice');
  static const EthereumMethods getAccounts = EthereumMethods._('eth_accounts');
  static const EthereumMethods getBlockNumber =
      EthereumMethods._('eth_blockNumber');
  static const EthereumMethods getBalance = EthereumMethods._('eth_getBalance');
  static const EthereumMethods getStorageAt =
      EthereumMethods._('eth_getStorageAt');
  static const EthereumMethods getTransactionCount =
      EthereumMethods._('eth_getTransactionCount');
  static const EthereumMethods getBlockTransactionCountByHash =
      EthereumMethods._('eth_getBlockTransactionCountByHash');
  static const EthereumMethods getBlockTransactionCountByNumber =
      EthereumMethods._('eth_getBlockTransactionCountByNumber');
  static const EthereumMethods getUncleCountByBlockHash =
      EthereumMethods._('eth_getUncleCountByBlockHash');
  static const EthereumMethods getUncleCountByBlockNumber =
      EthereumMethods._('eth_getUncleCountByBlockNumber');
  static const EthereumMethods getCode = EthereumMethods._('eth_getCode');
  static const EthereumMethods sign = EthereumMethods._('eth_sign');
  static const EthereumMethods signTransaction =
      EthereumMethods._('eth_signTransaction');
  static const EthereumMethods sendTransaction =
      EthereumMethods._('eth_sendTransaction');
  static const EthereumMethods sendRawTransaction =
      EthereumMethods._('eth_sendRawTransaction');
  static const EthereumMethods call = EthereumMethods._('eth_call');
  static const EthereumMethods estimateGas =
      EthereumMethods._('eth_estimateGas');
  static const EthereumMethods getBlockByHash =
      EthereumMethods._('eth_getBlockByHash');
  static const EthereumMethods getBlockByNumber =
      EthereumMethods._('eth_getBlockByNumber');
  static const EthereumMethods getTransactionByHash =
      EthereumMethods._('eth_getTransactionByHash');
  static const EthereumMethods getTransactionByBlockHashAndIndex =
      EthereumMethods._('eth_getTransactionByBlockHashAndIndex');
  static const EthereumMethods getTransactionByBlockNumberAndIndex =
      EthereumMethods._('eth_getTransactionByBlockNumberAndIndex');
  static const EthereumMethods getTransactionReceipt =
      EthereumMethods._('eth_getTransactionReceipt');
  static const EthereumMethods getUncleByBlockHashAndIndex =
      EthereumMethods._('eth_getUncleByBlockHashAndIndex');
  static const EthereumMethods getUncleByBlockNumberAndIndex =
      EthereumMethods._('eth_getUncleByBlockNumberAndIndex');
  static const EthereumMethods getCompilers =
      EthereumMethods._('eth_getCompilers');
  static const EthereumMethods compileSolidity =
      EthereumMethods._('eth_compileSolidity');
  static const EthereumMethods compileLLL = EthereumMethods._('eth_compileLLL');
  static const EthereumMethods compileSerpent =
      EthereumMethods._('eth_compileSerpent');
  static const EthereumMethods newFilter = EthereumMethods._('eth_newFilter');
  static const EthereumMethods newBlockFilter =
      EthereumMethods._('eth_newBlockFilter');
  static const EthereumMethods newPendingTransactionFilter =
      EthereumMethods._('eth_newPendingTransactionFilter');
  static const EthereumMethods uninstallFilter =
      EthereumMethods._('eth_uninstallFilter');
  static const EthereumMethods getFilterChanges =
      EthereumMethods._('eth_getFilterChanges');
  static const EthereumMethods getFilterLogs =
      EthereumMethods._('eth_getFilterLogs');
  static const EthereumMethods getLogs = EthereumMethods._('eth_getLogs');
  static const EthereumMethods getWork = EthereumMethods._('eth_getWork');
  static const EthereumMethods submitWork = EthereumMethods._('eth_submitWork');
  static const EthereumMethods submitHashrate =
      EthereumMethods._('eth_submitHashrate');
  static const EthereumMethods getFeeHistory =
      EthereumMethods._('eth_feeHistory');
  static const EthereumMethods getPendingTransactions =
      EthereumMethods._('eth_pendingTransactions');
  static const EthereumMethods requestAccounts =
      EthereumMethods._('eth_requestAccounts');
  static const EthereumMethods getChainId = EthereumMethods._('eth_chainId');
  static const EthereumMethods getProof = EthereumMethods._('eth_getProof');
  static const EthereumMethods getNodeInfo =
      EthereumMethods._('web3_clientVersion');
  static const EthereumMethods createAccessList =
      EthereumMethods._('eth_createAccessList');
  static const EthereumMethods signTypedData =
      EthereumMethods._('eth_signTypedData');
}
