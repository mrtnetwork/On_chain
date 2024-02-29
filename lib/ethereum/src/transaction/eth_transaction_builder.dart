import 'dart:async';

import 'package:on_chain/contract/fragments.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/keys/private_key.dart';
import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/methds/estimate_gas.dart';
import 'package:on_chain/ethereum/src/rpc/methds/fee_history.dart';
import 'package:on_chain/ethereum/src/rpc/methds/get_gas_price.dart';
import 'package:on_chain/ethereum/src/rpc/methds/get_transaction_count.dart';
import 'package:on_chain/ethereum/src/rpc/methds/get_transaction_receipt.dart';
import 'package:on_chain/ethereum/src/rpc/methds/send_raw_transaction.dart';
import 'package:on_chain/ethereum/src/models/transaction_receipt.dart';
import 'package:on_chain/ethereum/src/rpc/provider/provider.dart';
import 'package:on_chain/ethereum/src/models/access_list.dart';
import 'package:on_chain/ethereum/src/transaction/eth_transaction.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Enumeration for different fee rates in the context of EIP-1559 transactions.
enum EIP1559FeeRate { slow, normal, hight }

/// Builder class for creating Ethereum transactions.
class ETHTransactionBuilder {
  ETHTransactionBuilder._(this.to, this.from, this.value, this._data,
      this._type, this.function, this.functionParam, this.chainId);

  /// Factory constructor for creating a basic transaction.
  factory ETHTransactionBuilder(
      {required ETHAddress from,
      required ETHAddress to,
      required BigInt value,
      required BigInt chainId,
      String? memo,
      ETHTransactionType? transactionType}) {
    final List<int> data = memo == null ? [] : StringUtils.toBytes(memo);
    return ETHTransactionBuilder._(
        to, from, value, data, transactionType, null, null, chainId);
  }

  /// Factory constructor for creating a contract interaction transaction.
  factory ETHTransactionBuilder.contract(
      {required ETHAddress from,
      required ETHAddress contractAddress,
      required BigInt value,
      required BigInt chainId,
      required AbiFunctionFragment function,
      required List<dynamic> functionParams,
      String? memo,
      ETHTransactionType? transactionType}) {
    final contractData = function.encode(functionParams);
    final List<int> data = memo == null ? [] : StringUtils.toBytes(memo);
    if (value > BigInt.zero) {
      if (function.stateMutability != null &&
          function.stateMutability != StateMutability.payable) {
        throw const MessageException(
            "For calling non-payable methods, the transaction value must be set to zero.");
      }
    }
    return ETHTransactionBuilder._(
        contractAddress,
        from,
        value,
        [...contractData, ...data],
        transactionType,
        function,
        functionParams,
        chainId);
  }
  // Recipient address for the transaction.
  final ETHAddress to;

  // Sender address for the transaction.
  final ETHAddress from;

  // Value to be sent with the transaction.
  final BigInt value;

  // ABI function fragment if the transaction involves a contract function.
  final AbiFunctionFragment? function;

  // Parameters for the contract function, if applicable.
  final List<dynamic>? functionParam;

  // Chain ID for the Ethereum network.
  final BigInt chainId;

  // List of access list entries for EIP-1559 transactions.
  List<AccessListEntry>? _accessList;
  List<AccessListEntry>? get accessList => _accessList;

  // Transaction data payload.
  List<int> _data;

  String? get data => _data.isEmpty ? null : BytesUtils.toHexString(_data);

  // Type of the Ethereum transaction (legacy or EIP-1559).
  ETHTransactionType? _type;
  ETHTransactionType? get type => _type;

  // Nonce value for the transaction.
  int? _nonce;
  int? get nonce => _nonce;

  // Gas limit for the transaction.
  BigInt? _gasLimit;
  BigInt? get gasLimit => _gasLimit;

  // Gas price for legacy transactions.
  BigInt? _gasPrice;
  BigInt? get gasPrice => _gasPrice;

  // Max priority fee per gas for EIP-1559 transactions.
  BigInt? _maxPriorityFeePerGas;
  BigInt? get maxPriorityFeePerGas => _maxPriorityFeePerGas;

  // Max fee per gas for EIP-1559 transactions.
  BigInt? _maxFeePerGas;
  BigInt? get maxFeePerGas => _maxFeePerGas;

  // Signature information for the transaction.
  ETHSignature? _signature;

  // Flag indicating whether the transaction type is legacy or not.
  bool get _isLegacy => _type! != ETHTransactionType.eip1559;
  // Constructed ETHTransaction based on the provided configuration.
  late ETHTransaction _transaction = ETHTransaction(
      nonce: _nonce ?? 0,
      gasLimit: _gasLimit ?? BigInt.zero,
      data: _data,
      value: value,
      chainId: chainId,
      from: from,
      to: to,
      type: _type);

  List<int> get serializedTransaction => _transaction.serialized;
  List<int> signedSerializedTransaction([ETHSignature? signature]) {
    signature ??= _signature;
    if (signature == null) {
      throw const MessageException(
          "The transaction signed serialized cannot be obtained before the signing process.");
    }
    return _transaction.signedSerialized(signature);
  }

  /// Validates the Ethereum transaction configuration.
  ///
  /// Returns a map containing any validation errors found. An empty map indicates
  /// a valid configuration.
  Map<String, dynamic> _validate() {
    final Map<String, dynamic> errors = {};

    if (_nonce == null) {
      errors.addAll({"nonce": "must not be null"});
    }
    final t = _type ?? _transaction.transactionType;
    if (t == ETHTransactionType.eip1559) {
      if (maxPriorityFeePerGas == null) {
        errors.addAll({
          "maxFeePerGas": "must not be null",
          "maxPriorityFeePerGas": "must not be null",
        });
      }
    } else {
      if (gasPrice == null) {
        errors.addAll({"gasPrice": "must not be null"});
      }
    }
    if (gasLimit == null) {
      errors.addAll({"gasPrice": "must not be null"});
    }
    return errors;
  }

  /// Sets the nonce for the Ethereum transaction.
  ///
  /// Throws a [MessageException] if the provided nonce is `null`.
  void setNonce(int nonce) {
    _nonce = nonce;
    _replaceTr();
  }

  /// Sets the gas limit for the Ethereum transaction.
  ///
  /// Throws a [MessageException] if the provided gas limit is `null`.
  void setGasLimit(BigInt gasLimit) {
    _gasLimit = gasLimit;
    _replaceTr();
  }

  /// Sets the gas price for the Ethereum transaction.
  ///
  /// Throws a [MessageException] if the transaction type is EIP-1559, as gas price
  /// is not used in this type of transaction.
  void setGasPrice(BigInt gasPrice) {
    if (_type == ETHTransactionType.eip1559) {
      throw const MessageException(
          "Do not specify a gasPrice for non-legacy transactions.");
    }
    _gasPrice = gasPrice;
    _replaceTr();
  }

  /// Sets the fee details for an EIP-1559 Ethereum transaction.
  ///
  /// Throws a [MessageException] if the transaction type is not EIP-1559.
  void setEIP1559FeeDetails(BigInt maxFeePerGas, BigInt maxPriorityFeePerGas) {
    if (_type != ETHTransactionType.eip1559) {
      throw const MessageException(
          "Do not specify a maxPriorityFeePerGas and maxFeePerGas for legacy transactions. use setGasPrice");
    }
    _maxFeePerGas = maxFeePerGas;
    _maxPriorityFeePerGas = maxPriorityFeePerGas;
    _replaceTr();
  }

  /// Sets the access list for the Ethereum transaction.
  ///
  /// If the transaction type is legacy and the access list is not empty, the type is changed to EIP-2930.
  void setAccessList(List<AccessListEntry>? accessListEntry) {
    _accessList = accessListEntry;
    if (_type == ETHTransactionType.legacy) {
      if (accessList?.isNotEmpty ?? false) {
        _type = ETHTransactionType.eip2930;
      }
    }
    _replaceTr();
  }

  /// Calculates EIP-1559 transaction fees based on the specified fee rate.
  ///
  /// If the transaction is legacy, it fetches the gas price using RPC.
  /// For EIP-1559 transactions, it fetches historical fee data and calculates fees accordingly.
  Future<void> _calculateEIP1559Fee(EVMRPC rpc, EIP1559FeeRate feeRate) async {
    if (_isLegacy) {
      _gasPrice = await rpc.request(RPCGetGasPrice());
    } else {
      final historical = await rpc.request(RPCGetFeeHistory(
          blockCount: 10,
          newestBlock: BlockTagOrNumber.pending,
          rewardPercentiles: [25, 50, 75]));
      if (historical == null) {
        throw const MessageException(
            "The network in question does not currently support the London hard fork, including the EIP-1559 upgrade. use legacy transaction");
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
        default:
      }
    }
    _replaceTr();
  }

  /// Updates transaction fees using the provided EVMRPC and optional EIP-1559 fee rate.
  ///
  /// Calls the autoFill method to automatically determine the transaction type,
  /// fetch the nonce and gas limit, and calculate fees if necessary.
  Future<void> updateFees(EVMRPC rpc,
      [EIP1559FeeRate feeRate = EIP1559FeeRate.normal]) {
    return autoFill(rpc, feeRate);
  }

  /// Automatically fills in transaction details, such as type, nonce, gas limit, and fees.
  ///
  /// Determines the transaction type based on pending block information, fetches the nonce,
  /// gas limit, and calculates fees if required, updating the transaction accordingly.
  Future<void> autoFill(EVMRPC rpc,
      [EIP1559FeeRate feeRate = EIP1559FeeRate.normal]) async {
    if (_type == null) {
      final historical = await rpc.request(RPCGetFeeHistory(
          blockCount: 20,
          newestBlock: BlockTagOrNumber.latest,
          rewardPercentiles: [25, 60, 90]));
      if (historical != null) {
        _type = ETHTransactionType.eip1559;
      } else {
        _type = ETHTransactionType.legacy;
      }
    }
    _nonce ??= await rpc.request(RPCGetTransactionCount(address: from.address));
    _gasLimit ??= await rpc.request(RPCEstimateGas(
      transaction: _transaction.toEstimate(),
    ));
    if ((_isLegacy && _gasPrice == null) ||
        (!_isLegacy && _maxFeePerGas == null)) {
      await _calculateEIP1559Fee(rpc, feeRate);
    }
    _replaceTr();
  }

  /// Sets the provided ETHSignature for the transaction.
  void setSignature(ETHSignature signature) {
    _signature = signature;
  }

  /// Replaces the internal transaction with updated values.
  ///
  /// Invoked after modifying transaction parameters to ensure consistency.
  void _replaceTr() {
    _transaction = _transaction.copyWith(
        type: _type,
        gasLimit: _gasLimit,
        gasPrice: _gasPrice,
        maxFeePerGas: _maxFeePerGas,
        accessList: _accessList,
        nonce: nonce,
        maxPriorityFeePerGas: _maxPriorityFeePerGas);
    _signature = null;
  }

  /// Signs the transaction using the provided ETHPrivateKey.
  ///
  /// Generates a signature and sets it as the transaction's signature.
  void sign(ETHPrivateKey privateKey) {
    final serialized = _transaction.serialized;
    final signature = privateKey.sign(serialized);
    setSignature(signature);
  }

  /// Returns the transaction hash (ID) after the signing process.
  ///
  /// Throws an exception if the transaction is not signed.
  String get transactionID {
    if (_signature == null) {
      throw const MessageException(
          "The transaction hash cannot be obtained before the signing process.");
    }
    return BytesUtils.toHexString(
        QuickCrypto.keccack256Hash(signedSerializedTransaction()),
        prefix: "0x");
  }

  /// Checks for validation errors and throws an exception if any are found.
  void _checkError() {
    final errors = _validate();
    if (errors.isEmpty) return;
    throw MessageException("some fields not filled", details: errors);
  }

  /// Converts the transaction details into a map for estimating gas or access list.
  Map<String, dynamic> toEstimate() {
    return _transaction.toEstimate();
  }

  /// Sends the signed transaction to the Ethereum network via the provided RPC.
  ///
  /// Throws an exception if there are validation errors or if the RPC request fails.
  Future<String> sendTransaction(EVMRPC rpc) async {
    // Check for validation errors before sending the transaction
    _checkError();
    // Convert the signed transaction to raw hex format
    final rawHex =
        BytesUtils.toHexString(signedSerializedTransaction(), prefix: "0x");
    // Send the raw transaction hex to the Ethereum network
    final result =
        await rpc.request(RPCSendRawTransaction(transaction: rawHex));
    // Return the transaction hash upon successful submission
    return result;
  }

  /// Sends and monitors the transaction on the Ethereum network via the provided RPC.
  ///
  /// Throws an exception if there are validation errors, if the RPC request fails,
  /// or if the transaction receipt is not received within the specified timeout.
  Future<TransactionReceipt> sendAndSubmitTransaction(
    EVMRPC rpc, {
    Duration timeout = const Duration(minutes: 5),
    Duration periodicTimeOut = const Duration(seconds: 10),
  }) async {
    _checkError();
    Timer? timer;
    try {
      final rawHex =
          BytesUtils.toHexString(signedSerializedTransaction(), prefix: "0x");
      final result =
          await rpc.request(RPCSendRawTransaction(transaction: rawHex));
      final Completer<TransactionReceipt> completer =
          Completer<TransactionReceipt>();
      timer = Timer.periodic(periodicTimeOut, (t) async {
        final receipt = await rpc
            .request(RPCGetTransactionReceipt(transactionHash: result))
            .catchError((e, s) {
          return null;
        });
        if (receipt != null && !completer.isCompleted) {
          completer.complete(receipt);
        }
      });
      final receipt = await completer.future.timeout(timeout);
      return receipt;
    } finally {
      timer?.cancel();
      timer = null;
    }
  }
}
