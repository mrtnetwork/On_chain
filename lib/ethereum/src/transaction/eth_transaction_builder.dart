import 'dart:async';

import 'package:on_chain/ethereum/src/keys/signer.dart';
import 'package:on_chain/ethereum/src/models/authorization.dart';
import 'package:on_chain/ethereum/src/models/fee_history.dart';
import 'package:on_chain/ethereum/src/rpc/rpc.dart';
import 'package:on_chain/ethereum/src/transaction/zksync.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/solidity/contract/fragments.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/keys/private_key.dart';
import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/models/transaction_receipt.dart';
import 'package:on_chain/ethereum/src/models/access_list.dart';
import 'package:on_chain/ethereum/src/transaction/eth_transaction.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

typedef CbOnSubmitedTx = void Function(String txId);

/// Utility class for transaction receipt watching.
class ETHTransactionBuilderUtils {
  /// Polls every [blockInterval] until [timeout] or receipt is found.
  static Future<Stream<TransactionReceipt>> watchTransactionReceiptStream({
    required IProvider<IServiceProvider, EthereumRequestDetails> rpc,
    required String txId,
    Duration timeout = const Duration(minutes: 5),
    Duration blockInterval = const Duration(seconds: 10),
  }) async {
    Timer? timer;
    final StreamController<TransactionReceipt> controller = StreamController();
    void close() {
      if (!controller.isClosed) controller.close();
      timer?.cancel();
      timer = null;
    }

    void addResult(TransactionReceipt receipt) {
      if (controller.isClosed) return;
      controller.add(receipt);
      close();
    }

    void addError(Object err) {
      if (controller.isClosed) return;
      controller.addError(err);
      close();
    }

    void onListen() {
      timer = Timer.periodic(blockInterval, (t) async {
        final isEnd = t.tick * blockInterval.inSeconds >= timeout.inSeconds;
        try {
          final receipt = await rpc.request(
            EthereumRequestGetTransactionReceipt(transactionHash: txId),
          );
          if (receipt == null) return;
          addResult(receipt);
        } catch (e) {
          addError(e);
        } finally {
          if (isEnd) {
            addError(
              BuError(
                DefaultErrorType.invalidState,
                "Transaction receipt not found within timeout.",
                details: {"transactionHash": txId},
              ),
            );
          }
        }
      });
    }

    controller.onListen = onListen;
    return controller.stream.asBroadcastStream(
      onCancel: (subscription) {
        close();
      },
    );
  }

  /// Waits for the first transaction confirmation.
  ///
  /// Uses [watchTransactionReceiptStream] internally to poll for the receipt.
  static Future<TransactionReceipt> watchTransactionReceiptAsync({
    required IProvider<IServiceProvider, EthereumRequestDetails> rpc,
    required String txId,
    Duration timeout = const Duration(minutes: 5),
    Duration blockInterval = const Duration(seconds: 10),
  }) async {
    final stream = await watchTransactionReceiptStream(
      rpc: rpc,
      txId: txId,
      blockInterval: blockInterval,
      timeout: timeout,
    );
    final Completer<TransactionReceipt> completer = Completer();
    stream.listen(
      (event) {
        completer.complete(event);
      },
      onError: (e) {
        completer.completeError(e);
      },
    );
    return completer.future;
  }
}

class ETHTransactionParams {
  final BigInt? gasPrice;
  final BigInt? gasLimit;

  final BigInt? maxPriorityFeePerGas;
  final BigInt? maxFeePerGas;
  final BigInt? nonce;
  final List<AccessEntry>? accessList;
  final List<AuthorizationEntry>? authorizationList;
  final List<BuBytes>? blobVersionedHashes;
  final BigInt? maxFeePerBlobGas;
  final ZKSyncE712Parameters? zkParams;
  const ETHTransactionParams._({
    this.gasLimit,
    this.gasPrice,
    this.maxPriorityFeePerGas,
    this.maxFeePerGas,
    this.nonce,
    this.accessList,
    this.authorizationList,
    this.blobVersionedHashes,
    this.maxFeePerBlobGas,
    this.zkParams,
  });
  factory ETHTransactionParams({
    BigInt? gasPrice,
    BigInt? gasLimit,
    BigInt? maxPriorityFeePerGas,
    BigInt? maxFeePerGas,
    BigInt? nonce,
    List<AccessEntry>? accessList,
    List<AuthorizationEntry>? authorizationList,
    List<List<int>>? blobVersionedHashes,
    BigInt? maxFeePerBlobGas,
    ZKSyncE712Parameters? zkParams,
  }) {
    ETHTransactionUtils.validateTxParameters(
      accessList: accessList,
      authorizationList: authorizationList,
      blobVersionedHashes: blobVersionedHashes,
      gasPrice: gasPrice,
      maxFeePerGas: maxFeePerGas,
      maxFeePerBlobGas: maxFeePerBlobGas,
      maxPriorityFeePerGas: maxPriorityFeePerGas,
      zkParams: zkParams,
    );
    return ETHTransactionParams._(
      accessList: accessList,
      zkParams: zkParams,
      authorizationList: authorizationList,
      blobVersionedHashes:
          blobVersionedHashes?.map((e) => e.asImmutableBytes).toImutableList,
      gasLimit: gasLimit,
      gasPrice: gasPrice,
      maxFeePerBlobGas: maxFeePerBlobGas,
      maxFeePerGas: maxFeePerGas,
      maxPriorityFeePerGas: maxPriorityFeePerGas,
      nonce: nonce,
    );
  }
}

/// Fee rate options for EIP-1559 transactions.
enum EIP1559FeeRate { slow, normal, high }

/// Builder for creating Ethereum transactions.
class ETHTransactionBuilder {
  ETHTransactionBuilder._({
    required this.to,
    required this.from,
    required this.value,
    required List<int>? data,
    required this.type,
    required this.chainId,
  }) : _data = (data ?? <int>[]).asBytes;

  /// Creates a basic transaction builder.
  factory ETHTransactionBuilder({
    required ETHAddress from,
    required ETHAddress to,
    required BigInt value,
    required BigInt chainId,
    ETHTransactionParams? params,
    List<int>? data,
    ETHTransactionType? transactionType,
  }) {
    final transaction = ETHTransactionBuilder._(
      to: to,
      from: from,
      value: value,
      data: data,
      type: transactionType,
      chainId: chainId,
    );
    if (params != null) transaction.updateTxPrams(params);
    return transaction;
  }

  /// Creates a contract interaction transaction builder.
  @Deprecated('Use basic constructor with encoded data')
  factory ETHTransactionBuilder.contract({
    required ETHAddress from,
    required ETHAddress contractAddress,
    required BigInt value,
    required BigInt chainId,
    required AbiFunctionFragment function,
    required List<dynamic> functionParams,
    List<int>? data,
    ETHTransactionType? transactionType,
  }) {
    final contractData = function.encode(functionParams);
    if (value > BigInt.zero) {
      if (function.stateMutability != null &&
          function.stateMutability != StateMutability.payable) {
        throw const BuError(
          DefaultErrorType.invalidArgument,
          'For calling non-payable methods, the transaction value must be set to zero.',
        );
      }
    }
    return ETHTransactionBuilder._(
      to: contractAddress,
      from: from,
      value: value,
      data: [...contractData, ...data ?? []],
      type: transactionType,
      chainId: chainId,
    );
  }

  /// Recipient address.
  final ETHAddress to;

  /// Sender address.
  final ETHAddress from;

  /// Value to send.
  final BigInt value;

  /// Chain ID for the Ethereum network.
  final BigInt chainId;

  /// Type of the Ethereum transaction.
  final ETHTransactionType? type;

  /// List of access entries for EIP-2930 transactions.
  List<AccessEntry>? _accessList;
  List<AccessEntry>? get accessList => _accessList;

  BuBytes _data;

  /// Transaction data as hex string.
  String get data =>
      _data.isEmpty ? '0x' : BytesUtils.toHexString(_data, prefix: '0x');

  /// Nonce value for the transaction.
  int? _nonce;
  int? get nonce => _nonce;

  /// Gas limit for the transaction.
  BigInt? _gasLimit;
  BigInt? get gasLimit => _gasLimit;

  /// Gas price for legacy transactions.
  BigInt? _gasPrice;
  BigInt? get gasPrice => _gasPrice;

  /// Max priority fee per gas for EIP-1559 transactions.
  BigInt? _maxPriorityFeePerGas;
  BigInt? get maxPriorityFeePerGas => _maxPriorityFeePerGas;

  /// Max fee per gas for EIP-1559 transactions.
  BigInt? _maxFeePerGas;
  BigInt? get maxFeePerGas => _maxFeePerGas;

  /// List of authorization entries for EIP-7702 transactions.
  List<AuthorizationEntry>? _authorizationList;
  List<AuthorizationEntry>? get authorizationList => _authorizationList;

  /// blob for EIP-4844 transactions.
  List<BuBytes>? _blobVersionedHashes;
  List<BuBytes>? get blobVersionedHashes => _blobVersionedHashes;

  /// maxFeePerBlobGas for EIP-4844 transactions.
  BigInt? _maxFeePerBlobGas;
  BigInt? get maxFeePerBlobGas => _maxFeePerBlobGas;

  ZKSyncE712Parameters? _zkSyncParams;

  ZKSyncE712Parameters? get zkSyncParams => _zkSyncParams;

  /// Signature information for the transaction.
  IECDSASignature? _signature;

  bool get signed => _signature != null;

  /// Infers the transaction type from current parameters.
  ETHTransactionType? _getTxType() {
    ETHTransactionType? transactionType = type;
    if (transactionType != null) return transactionType;
    final isEIP1559 = maxFeePerGas != null || maxPriorityFeePerGas != null;
    final hasAccessList = accessList?.isNotEmpty ?? false;

    final hasAuthorizationList = authorizationList?.isNotEmpty ?? false;
    final isLegacy = gasPrice != null;
    final isEIP4844 = _blobVersionedHashes != null;
    final isEIP712 = _zkSyncParams != null;
    if (hasAuthorizationList) {
      return ETHTransactionType.eip7702;
    } else if (isEIP4844) {
      return ETHTransactionType.eip4844;
    } else if (isEIP1559) {
      return ETHTransactionType.eip1559;
    } else if (hasAccessList) {
      return ETHTransactionType.eip2930;
    } else if (isEIP712) {
      return ETHTransactionType.eip712;
    } else if (isLegacy) {
      return ETHTransactionType.legacy;
    }
    return transactionType;
  }

  late ETHTransaction _transaction = ETHTransaction(
    nonce: _nonce ?? 0,
    gasLimit: _gasLimit ?? BigInt.zero,
    data: _data,
    value: value,
    chainId: chainId,
    from: from,
    to: to,
    type: type,
  );

  /// Returns the raw serialized transaction (ready for signing).
  BuBytes get serializedTransaction => _transaction.serialized;

  /// Returns the raw serialized transaction (ready for submission).
  BuBytes signedSerializedTransaction([IECDSASignature? signature]) {
    signature ??= _signature;
    if (signature == null) {
      throw const BuError(
        DefaultErrorType.invalidState,
        'The transaction serialized bytes cannot be obtained before the signing process.',
      );
    }
    return _transaction.signedSerialized(signature);
  }

  /// Validates the transaction configuration.
  ///
  /// Returns a map of field names to error messages. Empty if valid.
  Map<String, String> _validate() {
    final Map<String, String> errors = {};

    if (_nonce == null) {
      errors.addAll({'nonce': 'must not be null'});
    }
    if (gasLimit == null) {
      errors.addAll({'gasLimit': 'must not be null'});
    }
    final t = _getTxType();
    Map<String, String> getEIP1559Error() {
      if (maxPriorityFeePerGas == null) {
        return {
          'maxFeePerGas': 'must not be null',
          'maxPriorityFeePerGas': 'must not be null',
        };
      }
      return {};
    }

    switch (t) {
      case ETHTransactionType.eip712:
      case ETHTransactionType.eip1559:
        errors.addAll(getEIP1559Error());
        break;
      case ETHTransactionType.eip4844:
        errors.addAll(getEIP1559Error());
        if (maxFeePerBlobGas == null) {
          errors.addAll({'maxFeePerBlobGas': 'must not be null'});
        }
        break;
      case ETHTransactionType.eip7702:
        errors.addAll(getEIP1559Error());
        break;
      default:
        if (gasPrice == null) {
          errors.addAll({'gasPrice': 'must not be null'});
        }
    }
    return errors;
  }

  /// Sets the transaction nonce.
  void setNonce(int nonce) {
    _nonce = nonce;
    _replaceTr();
  }

  /// Sets the gas limit.
  void setGasLimit(BigInt gasLimit) {
    _gasLimit = gasLimit;
    _replaceTr();
  }

  /// Sets the gas price (legacy transactions only).
  void setGasPrice(BigInt gasPrice) {
    final txType = _getTxType();
    switch (txType) {
      case null:
      case ETHTransactionType.legacy:
      case ETHTransactionType.eip2930:
        break;
      default:
        throw const BuError(
          OnChainErrorType.ethereumPlugin,
          'Do not specify a gasPrice for non-legacy transactions.',
        );
    }
    _gasPrice = gasPrice;
    _replaceTr();
  }

  /// Sets EIP-1559 fee details.
  void setEIP1559FeeDetails(BigInt maxFeePerGas, BigInt maxPriorityFeePerGas) {
    final txType = _getTxType();
    switch (txType) {
      case null:
      case ETHTransactionType.eip7702:
      case ETHTransactionType.eip4844:
      case ETHTransactionType.eip1559:
      case ETHTransactionType.eip712:
        break;
      default:
        throw const BuError(
          OnChainErrorType.ethereumPlugin,
          'Do not specify maxPriorityFeePerGas and maxFeePerGas for legacy transactions. Use setGasPrice.',
        );
    }
    _maxFeePerGas = maxFeePerGas;
    _maxPriorityFeePerGas = maxPriorityFeePerGas;
    _replaceTr();
  }

  /// Sets the access list.
  void setAccessList(List<AccessEntry>? accessList) {
    final txType = _getTxType();
    switch (txType) {
      case ETHTransactionType.legacy:
      case ETHTransactionType.eip712:
        throw BuError(
          OnChainErrorType.ethereumPlugin,
          'Do not specify an accessList for ${txType?.name} transaction.',
        );
      default:
        break;
    }
    _accessList = accessList;
    _replaceTr();
  }

  /// Sets EIP-7702 authorization parameters.
  void setEIP7702Params(List<AuthorizationEntry> authorizationList) {
    if (type != null && type != ETHTransactionType.eip7702) {
      throw BuError(
        OnChainErrorType.ethereumPlugin,
        'Do not specify EIP-7702 parameters for ${type?.name} transaction.',
      );
    }
    final txType = _getTxType();
    switch (txType) {
      case null:
      case ETHTransactionType.eip2930:
      case ETHTransactionType.eip1559:
      case ETHTransactionType.eip7702:
        break;
      default:
        throw BuError(
          OnChainErrorType.ethereumPlugin,
          'Do not specify EIP-7702 parameters for ${txType.name} transaction.',
        );
    }
    _authorizationList = authorizationList;
    _replaceTr();
  }

  /// Sets EIP-4844 blob parameters.
  void setEIP4844Params(
    List<List<int>> blobVersionedHashes,
    BigInt maxFeePerBlobGas,
  ) {
    if (type != null && type != ETHTransactionType.eip4844) {
      throw BuError(
        OnChainErrorType.ethereumPlugin,
        'Do not specify EIP-4844 parameters for ${type?.name} transaction.',
      );
    }
    final txType = _getTxType();
    switch (txType) {
      case null:
      case ETHTransactionType.eip2930:
      case ETHTransactionType.eip1559:
      case ETHTransactionType.eip4844:
        break;
      default:
        throw BuError(
          OnChainErrorType.ethereumPlugin,
          'Do not specify EIP-4844 parameters for ${txType.name} transaction.',
        );
    }
    _blobVersionedHashes =
        blobVersionedHashes.map((e) => e.asImmutableBytes).toImutableList;
    _maxFeePerBlobGas = maxFeePerBlobGas;
    _replaceTr();
  }

  /// Sets ZKSync EIP-712 parameters.
  void setEIP712Params(ZKSyncE712Parameters params) {
    if (type != null && type != ETHTransactionType.eip712) {
      throw BuError(
        OnChainErrorType.ethereumPlugin,
        'Do not specify EIP-712 parameters for ${type?.name} transaction.',
      );
    }
    final txType = _getTxType();
    switch (txType) {
      case null:
      case ETHTransactionType.eip712:
      case ETHTransactionType.eip1559:
        break;
      default:
        throw BuError(
          OnChainErrorType.ethereumPlugin,
          'Do not specify EIP-712 parameters for ${txType.name} transaction.',
        );
    }
    _zkSyncParams = params;
    _replaceTr();
  }

  /// Calculates EIP-1559 fees from RPC.
  Future<void> _calculateEIP1559Fee(
    IProvider<IServiceProvider, EthereumRequestDetails> rpc,
    EIP1559FeeRate feeRate,
  ) async {
    ETHTransactionType? type = _getTxType();
    FeeHistory? historical;
    if (type == null) {
      historical = await rpc.request(
        EthereumRequestGetFeeHistory(
          blockCount: 10,
          newestBlock: BlockTagOrNumber.latest,
          rewardPercentiles: [25, 50, 75],
        ),
      );
      if (historical == null) {
        type = ETHTransactionType.legacy;
      } else {
        type = ETHTransactionType.eip1559;
      }
    }
    switch (type) {
      case ETHTransactionType.legacy:
      case ETHTransactionType.eip2930:
        _gasPrice = await rpc.request(EthereumRequestGetGasPrice());
        break;
      default:
        historical ??= await rpc.request(
          EthereumRequestGetFeeHistory(
            blockCount: 10,
            newestBlock: BlockTagOrNumber.pending,
            rewardPercentiles: [25, 50, 75],
          ),
        );
        if (historical == null) {
          throw const BuError(
            OnChainErrorType.ethereumPlugin,
            'The network in question does not currently support the London hard fork, including the EIP-1559 upgrade. Use legacy transaction.',
          );
        }
        final fee = historical.toFee();
        switch (feeRate) {
          case EIP1559FeeRate.normal:
            _maxFeePerGas = fee.normal + fee.baseFee;
            _maxPriorityFeePerGas = fee.normal;
            break;
          case EIP1559FeeRate.high:
            _maxFeePerGas = fee.high + fee.baseFee;
            _maxPriorityFeePerGas = fee.high;
            break;
          case EIP1559FeeRate.slow:
            _maxFeePerGas = fee.slow + fee.baseFee;
            _maxPriorityFeePerGas = fee.slow;
            break;
        }
    }
    _replaceTr();
  }

  /// Updates fees using RPC.
  Future<void> updateFees(
    IProvider<IServiceProvider, EthereumRequestDetails> rpc, [
    EIP1559FeeRate feeRate = EIP1559FeeRate.normal,
  ]) {
    return autoFill(rpc, feeRate);
  }

  /// Auto-fills transaction details from RPC.
  Future<void> autoFill(
    IProvider<IServiceProvider, EthereumRequestDetails> rpc, [
    EIP1559FeeRate feeRate = EIP1559FeeRate.normal,
  ]) async {
    _nonce ??= await rpc.request(
      EthereumRequestGetTransactionCount(address: from.address),
    );
    _gasLimit ??= (await rpc.request(
      EthereumRequestEstimateGas(transaction: _transaction.toEstimate()),
    ));
    if ((_gasPrice == null) || (_maxFeePerGas == null)) {
      await _calculateEIP1559Fee(rpc, feeRate);
    }
    _replaceTr();
  }

  /// Estimates gas for the transaction.
  Future<BigInt> estimateGas(
    IProvider<IServiceProvider, EthereumRequestDetails> rpc,
  ) async {
    return await rpc.request(
      EthereumRequestEstimateGas(transaction: _transaction.toEstimate()),
    );
  }

  /// Gets the gas price or max fee for the transaction.
  Future<BigInt> getGasPrice(
    IProvider<IServiceProvider, EthereumRequestDetails> rpc, [
    EIP1559FeeRate feeRate = EIP1559FeeRate.normal,
  ]) async {
    ETHTransactionType? type = _getTxType();
    FeeHistory? historical;
    if (type == null) {
      historical = await rpc.request(
        EthereumRequestGetFeeHistory(
          blockCount: 10,
          newestBlock: BlockTagOrNumber.latest,
          rewardPercentiles: [25, 50, 75],
        ),
      );
      if (historical == null) {
        type = ETHTransactionType.legacy;
      } else {
        type = ETHTransactionType.eip1559;
      }
    }
    switch (type) {
      case ETHTransactionType.legacy:
      case ETHTransactionType.eip2930:
        final gasPrice = _gasPrice;
        if (gasPrice != null) return gasPrice;
        return await rpc.request(EthereumRequestGetGasPrice());
      default:
        final max = _maxFeePerGas;
        if (max != null) return max;
        historical ??= await rpc.request(
          EthereumRequestGetFeeHistory(
            blockCount: 10,
            newestBlock: BlockTagOrNumber.pending,
            rewardPercentiles: [25, 50, 75],
          ),
        );
        if (historical == null) {
          throw const BuError(
            DefaultErrorType.unsupported,
            'The network does not support the London hard fork (EIP-1559). Use legacy transaction.',
          );
        }
        final fee = historical.toFee();
        switch (feeRate) {
          case EIP1559FeeRate.normal:
            return fee.normal + fee.baseFee;
          case EIP1559FeeRate.high:
            return fee.high + fee.baseFee;
          case EIP1559FeeRate.slow:
            return fee.slow + fee.baseFee;
        }
    }
  }

  /// Sets the transaction signature.
  void setSignature(IECDSASignature signature) {
    _signature = signature;
  }

  /// Rebuilds the internal transaction with current parameters.
  void _replaceTr() {
    _transaction = _transaction.copyWith(
      type: type,
      gasLimit: _gasLimit,
      gasPrice: _gasPrice,
      maxFeePerGas: _maxFeePerGas,
      authorizationList: authorizationList,
      blobVersionedHashes: blobVersionedHashes,
      maxFeePerBlobGas: maxFeePerBlobGas,
      accessList: _accessList,
      nonce: nonce,
      zkSyncParams: _zkSyncParams,
      maxPriorityFeePerGas: _maxPriorityFeePerGas,
    );
    _signature = null;
  }

  /// Signs the transaction with a private key.
  void sign(ETHPrivateKey privateKey) {
    final serialized = _transaction.serialized;
    final signature = privateKey.sign(serialized);
    setSignature(signature);
  }

  /// Asynchronously signs the transaction.
  Future<void> signAsync(EthereumSigner privateKey) async {
    final serialized = _transaction.serialized;
    final signature = await privateKey.signAsync(serialized);
    setSignature(signature);
  }

  /// Returns the transaction hash (requires signing).
  String get transactionID {
    if (_signature == null) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'The transaction hash cannot be obtained before the signing process.',
      );
    }
    return BytesUtils.toHexString(
      QuickCrypto.keccak256Hash(signedSerializedTransaction()),
      prefix: '0x',
    );
  }

  /// Validates and throws if errors exist.
  void _checkError() {
    final errors = _validate();
    if (errors.isEmpty) return;
    throw BuError(
      OnChainErrorType.ethereumPlugin,
      'Some transaction fields are not filled.',
      details: errors,
    );
  }

  /// Returns transaction estimate map.
  Map<String, dynamic> toEstimate() {
    return _transaction.toEstimate();
  }

  /// Updates transaction with parameters.
  void updateTxPrams(ETHTransactionParams params) {
    if (params.gasLimit != null) setGasLimit(params.gasLimit!);
    if (params.gasPrice != null) setGasPrice(params.gasPrice!);
    if (params.maxFeePerGas != null) {
      setEIP1559FeeDetails(params.maxFeePerGas!, params.maxPriorityFeePerGas!);
    }
    if (params.accessList != null) {
      setAccessList(params.accessList);
    }
    if (params.authorizationList != null) {
      setEIP7702Params(params.authorizationList!);
    }
    if (params.blobVersionedHashes != null) {
      setEIP4844Params(params.blobVersionedHashes!, params.maxFeePerBlobGas!);
    }
    if (params.zkParams != null) {
      setEIP712Params(params.zkParams!);
    }
  }

  /// Submits the signed transaction to the network.
  Future<String> submitTransaction(
    IProvider<IServiceProvider, EthereumRequestDetails> rpc,
  ) async {
    _checkError();

    final rawHex = BytesUtils.toHexString(
      signedSerializedTransaction(),
      prefix: '0x',
    );

    final result = await rpc.request(
      EthereumRequestSendRawTransaction(transaction: rawHex),
    );

    return result;
  }

  /// Submits transaction and returns a stream of receipts.
  Future<Stream<TransactionReceipt>> submitAndWatchTransactionStream(
    IProvider<IServiceProvider, EthereumRequestDetails> rpc, {
    Duration timeout = const Duration(minutes: 5),
    Duration blockInterval = const Duration(seconds: 10),
    CbOnSubmitedTx? onTxSubmited,
  }) async {
    final txId = await submitTransaction(rpc);
    if (onTxSubmited != null) onTxSubmited(txId);
    return ETHTransactionBuilderUtils.watchTransactionReceiptStream(
      rpc: rpc,
      txId: txId,
      blockInterval: blockInterval,
      timeout: timeout,
    );
  }

  /// Submits transaction and waits for confirmation.
  Future<TransactionReceipt> submitAndWatchTransactionAsync(
    IProvider<IServiceProvider, EthereumRequestDetails> rpc, {
    Duration timeout = const Duration(minutes: 5),
    Duration blockInterval = const Duration(seconds: 10),
    CbOnSubmitedTx? onTxSubmited,
  }) async {
    final txId = await submitTransaction(rpc);
    if (onTxSubmited != null) onTxSubmited(txId);
    return ETHTransactionBuilderUtils.watchTransactionReceiptAsync(
      rpc: rpc,
      txId: txId,
      blockInterval: blockInterval,
      timeout: timeout,
    );
  }

  /// Returns transaction as JSON map.
  Map<String, dynamic> toJson() {
    return {
      'type': type?.name,
      'to': to.address,
      'from': from.address,
      'nonce': nonce,
      'gasLimit': gasLimit?.toString(),
      'gasPrice': gasPrice?.toString(),
      'maxPriorityFeePerGas': maxPriorityFeePerGas?.toString(),
      "blobVersionedHashes":
          blobVersionedHashes
              ?.map((e) => BytesUtils.toHexString(e, prefix: "0x"))
              .toList(),
      'maxFeePerGas': maxFeePerGas?.toString(),
      "maxFeePerBlobGas": maxFeePerBlobGas?.toString(),
      'data': data,
      'value': value.toString(),
      'chainId': chainId.toString(),
      'accessList': accessList?.map((e) => e.toJson()).toList(),
      'authorizationList': authorizationList?.map((e) => e.toJson()).toList(),
      'signature':
          _signature == null
              ? null
              : {
                's': _signature?.s.toBigInt().toHexaDecimal,
                'r': _signature?.r.toBigInt().toHexaDecimal,
                'v': _signature?.recoveryId?.toHexaDecimal,
              },
    };
  }
}
