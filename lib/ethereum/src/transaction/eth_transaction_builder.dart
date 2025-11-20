import 'dart:async';

import 'package:on_chain/ethereum/src/exception/exception.dart';
import 'package:on_chain/ethereum/src/keys/signer.dart';
import 'package:on_chain/ethereum/src/models/autorization.dart';
import 'package:on_chain/ethereum/src/models/fee_history.dart';
import 'package:on_chain/ethereum/src/rpc/rpc.dart';
import 'package:on_chain/ethereum/src/transaction/zksync.dart';
import 'package:on_chain/solidity/contract/fragments.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/keys/private_key.dart';
import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/models/transaction_receipt.dart';
import 'package:on_chain/ethereum/src/models/access_list.dart';
import 'package:on_chain/ethereum/src/transaction/eth_transaction.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

typedef ONTRANSACTIONSUBMITED = void Function(String txId);

class ETHTransactionBuilderUtils {
  /// Stream of transaction receipts.
  ///
  /// The stream periodically checks for the transaction receipt every [blockInternal].
  /// Stops emitting events when the transaction is confirmed or after [timeout].
  static Future<Stream<TransactionReceipt>> watchTransactionReceiptStream(
      {required EthereumProvider rpc,
      required String txId,
      Duration timeout = const Duration(minutes: 5),
      Duration blockInternal = const Duration(seconds: 10)}) async {
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
      timer = Timer.periodic(blockInternal, (t) async {
        final inEnd = t.tick * blockInternal.inSeconds >= timeout.inSeconds;
        try {
          final receipt = await rpc.request(
              EthereumRequestGetTransactionReceipt(transactionHash: txId));
          if (receipt == null) return;
          addResult(receipt);
        } catch (e) {
          addError(e);
        } finally {
          if (inEnd) addError(ETHPluginException("Transaction not found."));
        }
      });
    }

    controller.onListen = onListen;
    return controller.stream.asBroadcastStream(onCancel: (subscription) {
      close();
    });
  }

  /// Waits for the first confirmation asynchronously.
  ///
  /// Internally uses [watchTransactionReceiptStream] to poll for the receipt
  /// every [blockInternal] interval until the transaction is confirmed or [timeout] is reached.
  static Future<TransactionReceipt> watchTransactionReceiptAsync({
    required EthereumProvider rpc,
    required String txId,
    Duration timeout = const Duration(minutes: 5),
    Duration blockInternal = const Duration(seconds: 10),
  }) async {
    final stream = await watchTransactionReceiptStream(
        rpc: rpc, txId: txId, blockInternal: blockInternal, timeout: timeout);
    final Completer<TransactionReceipt> completer = Completer();
    stream.listen((event) {
      completer.complete(event);
    }, onError: (e) {
      completer.completeError(e);
    });
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
  final List<List<int>>? blobVersionedHashes;
  final BigInt? maxFeePerBlobGas;
  final ZKSyncE712Parameters? zkParams;
  const ETHTransactionParams._(
      {this.gasLimit,
      this.gasPrice,
      this.maxPriorityFeePerGas,
      this.maxFeePerGas,
      this.nonce,
      this.accessList,
      this.authorizationList,
      this.blobVersionedHashes,
      this.maxFeePerBlobGas,
      this.zkParams});
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
        zkParams: zkParams);
    return ETHTransactionParams._(
        accessList: accessList,
        zkParams: zkParams,
        authorizationList: authorizationList,
        blobVersionedHashes: blobVersionedHashes,
        gasLimit: gasLimit,
        gasPrice: gasPrice,
        maxFeePerBlobGas: maxFeePerBlobGas,
        maxFeePerGas: maxFeePerGas,
        maxPriorityFeePerGas: maxPriorityFeePerGas,
        nonce: nonce);
  }
}

//// Enumeration for different fee rates in the context of EIP-1559 transactions.
enum EIP1559FeeRate { slow, normal, hight }

//// Builder class for creating Ethereum transactions.
class ETHTransactionBuilder {
  ETHTransactionBuilder._(
      {required this.to,
      required this.from,
      required this.value,
      required List<int>? data,
      required this.type,
      required this.chainId})
      : _data = (data ?? <int>[]).asImmutableBytes;

  //// Factory constructor for creating a basic transaction.
  factory ETHTransactionBuilder(
      {required ETHAddress from,
      required ETHAddress to,
      required BigInt value,
      required BigInt chainId,
      ETHTransactionParams? params,
      List<int>? data,
      ETHTransactionType? transactionType}) {
    final transaction = ETHTransactionBuilder._(
        to: to,
        from: from,
        value: value,
        data: data,
        type: transactionType,
        chainId: chainId);
    if (params != null) transaction.updateTxPrams(params);
    return transaction;
  }

  //// Factory constructor for creating a contract interaction transaction.
  @Deprecated("")
  factory ETHTransactionBuilder.contract(
      {required ETHAddress from,
      required ETHAddress contractAddress,
      required BigInt value,
      required BigInt chainId,
      required AbiFunctionFragment function,
      required List<dynamic> functionParams,
      List<int>? data,
      ETHTransactionType? transactionType}) {
    final contractData = function.encode(functionParams);
    if (value > BigInt.zero) {
      if (function.stateMutability != null &&
          function.stateMutability != StateMutability.payable) {
        throw const ETHPluginException(
            'For calling non-payable methods, the transaction value must be set to zero.');
      }
    }
    return ETHTransactionBuilder._(
        to: contractAddress,
        from: from,
        value: value,
        data: [...contractData, ...data ?? []],
        type: transactionType,
        chainId: chainId);
  }

  //// Recipient address for the transaction.
  final ETHAddress to;

  //// Sender address for the transaction.
  final ETHAddress from;

  //// Value to be sent with the transaction.
  final BigInt value;

  /// Chain ID for the Ethereum network.
  final BigInt chainId;

  /// Type of the Ethereum transaction.
  final ETHTransactionType? type;

  /// List of access entries for EIP-2930 transactions.
  List<AccessEntry>? _accessList;
  List<AccessEntry>? get accessList => _accessList;

  /// Transaction data payload.
  List<int> _data;

  String get data =>
      _data.isEmpty ? "0x" : BytesUtils.toHexString(_data, prefix: "0x");

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
  List<List<int>>? _blobVersionedHashes;
  List<List<int>>? get blobVersionedHashes => _blobVersionedHashes;

  /// maxFeePerBlobGas for EIP-4844 transactions.
  BigInt? _maxFeePerBlobGas;
  BigInt? get maxFeePerBlobGas => _maxFeePerBlobGas;

  ZKSyncE712Parameters? _zkSyncParams;

  ZKSyncE712Parameters? get zkSyncParams => _zkSyncParams;

  /// Signature information for the transaction.
  ETHSignature? _signature;

  bool get signed => _signature != null;

  ETHTransactionType? _getTxType() {
    ETHTransactionType? transactionType = type;
    if (transactionType != null) return transactionType;
    final isEIP1559 = maxFeePerGas != null || maxPriorityFeePerGas != null;
    final hasAccessList = accessList?.isNotEmpty ?? false;
    final hasAutorizationList = authorizationList?.isNotEmpty ?? false;
    final isLegacy = gasPrice != null;
    final isEIP4844 = _blobVersionedHashes != null;
    final isEIP712 = _zkSyncParams != null;
    if (hasAutorizationList) {
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

  /// Constructed ETHTransaction based on the provided configuration.
  late ETHTransaction _transaction = ETHTransaction(
      nonce: _nonce ?? 0,
      gasLimit: _gasLimit ?? BigInt.zero,
      data: _data,
      value: value,
      chainId: chainId,
      from: from,
      to: to,
      type: type);

  /// Returns the raw serialized transaction (ready for signing).
  List<int> get serializedTransaction => _transaction.serialized;

  /// Returns the raw serialized transaction (ready for submittion).
  List<int> signedSerializedTransaction([ETHSignature? signature]) {
    signature ??= _signature;
    if (signature == null) {
      throw const ETHPluginException(
          'The transaction signed serialized cannot be obtained before the signing process.');
    }
    return _transaction.signedSerialized(signature);
  }

  //// Validates the Ethereum transaction configuration.
  ///
  //// Returns a map containing any validation errors found. An empty map indicates
  //// a valid configuration.
  Map<String, dynamic> _validate() {
    final Map<String, dynamic> errors = {};

    if (_nonce == null) {
      errors.addAll({'nonce': 'must not be null'});
    }
    if (gasLimit == null) {
      errors.addAll({'gasLimit': 'must not be null'});
    }
    final t = _getTxType();
    Map<String, dynamic> getEIP1559Error() {
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
          errors.addAll({
            'maxFeePerBlobGas': 'must not be null',
          });
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

  //// Sets the nonce for the Ethereum transaction.
  void setNonce(int nonce) {
    _nonce = nonce;
    _replaceTr();
  }

  //// Sets the gas limit for the Ethereum transaction.
  void setGasLimit(BigInt gasLimit) {
    _gasLimit = gasLimit;
    _replaceTr();
  }

  //// Sets the gas price for the Ethereum transaction.
  ///
  //// Throws a [ETHTransactionType] if the transaction type is not legacy, as gas price
  //// is not used in this type of transaction.
  void setGasPrice(BigInt gasPrice) {
    final txType = _getTxType();
    switch (txType) {
      case null:
      case ETHTransactionType.legacy:
      case ETHTransactionType.eip2930:
        break;
      default:
        throw const ETHPluginException(
            'Do not specify a gasPrice for non-legacy transactions.');
    }
    _gasPrice = gasPrice;
    _replaceTr();
  }

  //// Sets the fee details for an EIP-1559 Ethereum transaction.
  ///
  //// Throws a [ETHTransactionType] if the transaction is legacy.
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
        throw const ETHPluginException(
            'Do not specify a maxPriorityFeePerGas and maxFeePerGas for legacy transactions. use setGasPrice');
    }
    _maxFeePerGas = maxFeePerGas;
    _maxPriorityFeePerGas = maxPriorityFeePerGas;
    _replaceTr();
  }

  //// Sets the access list for the Ethereum transaction.
  ///
  /// Throws an [ETHPluginException] if:
  /// - The explicit [type] is set and is [ETHTransactionType.legacy]`, or
  /// - The inferred transaction type does not support access list.
  void setAccessList(List<AccessEntry>? accessList) {
    final txType = _getTxType();
    switch (txType) {
      case ETHTransactionType.legacy:
      case ETHTransactionType.eip712:
        throw ETHPluginException(
            'Do not specify a accessList for ${txType?.name} transaction.');
      default:
        break;
    }
    _accessList = accessList;
    _replaceTr();
  }

  /// Sets the EIP-7702 authorization parameters for the transaction.
  ///
  /// Throws an [ETHPluginException] if:
  /// - The explicit [type] is set and is not [ETHTransactionType.eip7702]`, or
  /// - The inferred transaction type does not support EIP-7702.
  void setEIP7702Params(List<AuthorizationEntry> authorizationList) {
    if (type != null && type != ETHTransactionType.eip7702) {
      throw ETHPluginException(
          'Do not specify a EIP-7702 parameters for ${type?.name} transaction.');
    }
    final txType = _getTxType();
    switch (txType) {
      case null:
      case ETHTransactionType.eip2930:
      case ETHTransactionType.eip1559:
      case ETHTransactionType.eip7702:
        break;
      default:
        throw ETHPluginException(
            'Do not specify a EIP-7702 parameters for ${type?.name} transaction.');
    }
    _authorizationList = authorizationList;
    _replaceTr();
  }

  /// Sets the EIP-4844 parameters for the transaction.
  ///
  /// Throws an [ETHPluginException] if:
  /// - The explicit [type] is set and is not [ETHTransactionType.eip4844], or
  /// - The inferred transaction type does not support EIP-4844.
  void setEIP4844Params(
      List<List<int>> blobVersionedHashes, BigInt maxFeePerBlobGas) {
    if (type != null && type != ETHTransactionType.eip4844) {
      throw ETHPluginException(
          'Do not specify a EIP-4844 parameters for ${type?.name} transaction.');
    }
    final txType = _getTxType();
    switch (txType) {
      case null:
      case ETHTransactionType.eip2930:
      case ETHTransactionType.eip1559:
      case ETHTransactionType.eip4844:
        break;
      default:
        throw ETHPluginException(
            'Do not specify a EIP-7702 parameters for ${type?.name} transaction.');
    }
    _blobVersionedHashes =
        blobVersionedHashes.map((e) => e.asImmutableBytes).toImutableList;
    _maxFeePerBlobGas = maxFeePerBlobGas;
    _replaceTr();
  }

  /// Sets the EIP-4844 parameters for the transaction.
  ///
  /// Throws an [ETHPluginException] if:
  /// - The explicit [type] is set and is not [ETHTransactionType.eip4844], or
  /// - The inferred transaction type does not support EIP-4844.
  void setEIP712Params(ZKSyncE712Parameters params) {
    if (type != null && type != ETHTransactionType.eip712) {
      throw ETHPluginException(
          'Do not specify a EIP-712 parameters for ${type?.name} transaction.');
    }
    final txType = _getTxType();
    switch (txType) {
      case null:
      case ETHTransactionType.eip712:
      case ETHTransactionType.eip1559:
        break;
      default:
        throw ETHPluginException(
            'Do not specify a EIP-712 parameters for ${type?.name} transaction.');
    }
    _zkSyncParams = params;
    _replaceTr();
  }

  //// Calculates EIP-1559 transaction fees based on the specified fee rate.
  ///
  //// If the transaction is legacy, it fetches the gas price using RPC.
  //// For EIP-1559 transactions, it fetches historical fee data and calculates fees accordingly.
  Future<void> _calculateEIP1559Fee(
      EthereumProvider rpc, EIP1559FeeRate feeRate) async {
    ETHTransactionType? type = _getTxType();
    FeeHistory? historical;
    if (type == null) {
      historical = await rpc.request(EthereumRequestGetFeeHistory(
          blockCount: 10,
          newestBlock: BlockTagOrNumber.latest,
          rewardPercentiles: [25, 50, 75]));
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
        historical ??= await rpc.request(EthereumRequestGetFeeHistory(
            blockCount: 10,
            newestBlock: BlockTagOrNumber.pending,
            rewardPercentiles: [25, 50, 75]));
        if (historical == null) {
          throw const ETHPluginException(
              'The network in question does not currently support the London hard fork, including the EIP-1559 upgrade. use legacy transaction');
        }
        final fee = historical.toFee();
        switch (feeRate) {
          case EIP1559FeeRate.normal:
            _maxFeePerGas = fee.normal + fee.baseFee;
            _maxPriorityFeePerGas = fee.normal;
            break;
          case EIP1559FeeRate.hight:
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

  //// Updates transaction fees using the provided EthereumProvider and optional EIP-1559 fee rate.
  ///
  //// Calls the autoFill method to automatically determine the transaction type,
  //// fetch the nonce and gas limit, and calculate fees if necessary.
  Future<void> updateFees(EthereumProvider rpc,
      [EIP1559FeeRate feeRate = EIP1559FeeRate.normal]) {
    return autoFill(rpc, feeRate);
  }

  //// Automatically fills in transaction details, such as type, nonce, gas limit, and fees.
  ///
  //// Determines the transaction type based on pending block information, fetches the nonce,
  //// gas limit, and calculates fees if required, updating the transaction accordingly.
  Future<void> autoFill(EthereumProvider rpc,
      [EIP1559FeeRate feeRate = EIP1559FeeRate.normal]) async {
    _nonce ??= await rpc
        .request(EthereumRequestGetTransactionCount(address: from.address));
    _gasLimit ??= (await rpc.request(EthereumRequestEstimateGas(
      transaction: _transaction.toEstimate(),
    )));
    if ((_gasPrice == null) || (_maxFeePerGas == null)) {
      await _calculateEIP1559Fee(rpc, feeRate);
    }
    _replaceTr();
  }

  Future<BigInt> estimateGas(EthereumProvider rpc) async {
    return await rpc.request(
        EthereumRequestEstimateGas(transaction: _transaction.toEstimate()));
  }

  Future<BigInt> getGasPrice(EthereumProvider rpc,
      [EIP1559FeeRate feeRate = EIP1559FeeRate.normal]) async {
    ETHTransactionType? type = _getTxType();
    FeeHistory? historical;
    if (type == null) {
      historical = await rpc.request(EthereumRequestGetFeeHistory(
          blockCount: 10,
          newestBlock: BlockTagOrNumber.latest,
          rewardPercentiles: [25, 50, 75]));
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
        historical ??= await rpc.request(EthereumRequestGetFeeHistory(
            blockCount: 10,
            newestBlock: BlockTagOrNumber.pending,
            rewardPercentiles: [25, 50, 75]));
        if (historical == null) {
          throw const ETHPluginException(
              'The network in question does not currently support the London hard fork, including the EIP-1559 upgrade. use legacy transaction');
        }
        final fee = historical.toFee();
        switch (feeRate) {
          case EIP1559FeeRate.normal:
            return fee.normal + fee.baseFee;
          case EIP1559FeeRate.hight:
            return fee.high + fee.baseFee;
          case EIP1559FeeRate.slow:
            return fee.slow + fee.baseFee;
        }
    }
  }

  //// Sets the provided ETHSignature for the transaction.
  void setSignature(ETHSignature signature) {
    _signature = signature;
  }

  //// Replaces the internal transaction with updated values.
  ///
  //// Invoked after modifying transaction parameters to ensure consistency.
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
        maxPriorityFeePerGas: _maxPriorityFeePerGas);
    _signature = null;
  }

  //// Signs the transaction using the provided ETHPrivateKey.
  ///
  //// Generates a signature and sets it as the transaction's signature.
  void sign(ETHPrivateKey privateKey) {
    final serialized = _transaction.serialized;
    final signature = privateKey.sign(serialized);
    setSignature(signature);
  }

  //// Signs the transaction using the provided ETHPrivateKey.
  ///
  //// Generates a signature and sets it as the transaction's signature.
  Future<void> signAsync(EthereumSigner privateKey) async {
    final serialized = _transaction.serialized;
    final signature = await privateKey.signAsync(serialized);
    setSignature(signature);
  }

  //// Returns the transaction hash (ID) after the signing process.
  ///
  //// Throws an exception if the transaction is not signed.
  String get transactionID {
    if (_signature == null) {
      throw const ETHPluginException(
          'The transaction hash cannot be obtained before the signing process.');
    }
    return BytesUtils.toHexString(
        QuickCrypto.keccack256Hash(signedSerializedTransaction()),
        prefix: '0x');
  }

  //// Checks for validation errors and throws an exception if any are found.
  void _checkError() {
    final errors = _validate();
    if (errors.isEmpty) return;
    throw ETHPluginException('some fields not filled', details: errors);
  }

  //// Converts the transaction details into a map for estimating gas or access list.
  Map<String, dynamic> toEstimate() {
    return _transaction.toEstimate();
  }

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

  //// Sends the signed transaction to the Ethereum network via the provided RPC.
  ///
  //// Throws an exception if there are validation errors or if the RPC request fails.
  Future<String> submitTransaction(EthereumProvider rpc) async {
    /// Check for validation errors before sending the transaction
    _checkError();

    /// Convert the signed transaction to raw hex format
    final rawHex =
        BytesUtils.toHexString(signedSerializedTransaction(), prefix: '0x');

    /// Send the raw transaction hex to the Ethereum network
    final result = await rpc
        .request(EthereumRequestSendRawTransaction(transaction: rawHex));

    /// Return the transaction hash upon successful submission
    return result;
  }

  /// Sends the transaction and returns a stream of transaction receipts.
  ///
  /// The stream periodically checks for the transaction receipt every [blockInternal].
  /// Stops emitting events when the transaction is confirmed or after [timeout].
  /// Optionally calls [onTxSubmited] with the transaction hash once submitted.
  Future<Stream<TransactionReceipt>> submitAndWatchTransactionStream(
      EthereumProvider rpc,
      {Duration timeout = const Duration(minutes: 5),
      Duration blockInternal = const Duration(seconds: 10),
      ONTRANSACTIONSUBMITED? onTxSubmited}) async {
    final txId = await submitTransaction(rpc);
    if (onTxSubmited != null) onTxSubmited(txId);
    return ETHTransactionBuilderUtils.watchTransactionReceiptStream(
        rpc: rpc, txId: txId, blockInternal: blockInternal, timeout: timeout);
  }

  /// Sends the transaction and waits for the first confirmation asynchronously.
  ///
  /// Internally uses [submitAndWatchTransactionStream] to poll for the receipt
  /// every [blockInternal] interval until the transaction is confirmed or [timeout] is reached.
  /// Optionally calls [onTxSubmited] when the transaction is submitted.
  Future<TransactionReceipt> submitAndWatchTransactionAsync(
      EthereumProvider rpc,
      {Duration timeout = const Duration(minutes: 5),
      Duration blockInternal = const Duration(seconds: 10),
      ONTRANSACTIONSUBMITED? onTxSubmited}) async {
    final txId = await submitTransaction(rpc);
    if (onTxSubmited != null) onTxSubmited(txId);
    return ETHTransactionBuilderUtils.watchTransactionReceiptAsync(
        rpc: rpc, txId: txId, blockInternal: blockInternal, timeout: timeout);
  }

  /// Converts the transaction details into a json.
  Map<String, dynamic> toJson() {
    return {
      'type': type?.name,
      'to': to.address,
      'from': from.address,
      'nonce': nonce,
      'gasLimit': gasLimit?.toString(),
      'gasPrice': gasPrice?.toString(),
      'maxPriorityFeePerGas': maxPriorityFeePerGas?.toString(),
      "blobVersionedHashes": blobVersionedHashes
          ?.map((e) => BytesUtils.toHexString(e, prefix: "0x"))
          .toList(),
      'maxFeePerGas': maxFeePerGas?.toString(),
      "maxFeePerBlobGas": maxFeePerBlobGas?.toString(),
      'data': data,
      'value': value.toString(),
      'chainId': chainId.toString(),
      'accessList': accessList?.map((e) => e.toJson()).toList(),
      'authorizationList': authorizationList?.map((e) => e.toJson()).toList(),
      'signature': _signature == null
          ? null
          : {
              's': "0x${_signature?.s.toRadixString(16)}",
              'r': "0x${_signature?.r.toRadixString(16)}",
              'v': "0x${_signature?.v.toRadixString(16)}"
            }
    };
  }
}
