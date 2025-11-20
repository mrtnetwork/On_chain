import 'package:blockchain_utils/helper/helper.dart';
import 'package:blockchain_utils/signer/const/constants.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/contracts/safe/controller/controller.dart';
import 'package:on_chain/ethereum/src/contracts/safe/types/contracts.dart';
import 'package:on_chain/ethereum/src/contracts/safe/types/events.dart';
import 'package:on_chain/ethereum/src/contracts/safe/utils/utils.dart';
import 'package:on_chain/ethereum/src/models/transaction_receipt.dart';
import 'package:on_chain/ethereum/src/rpc/rpc.dart';

typedef ONREQUESTETHPROVIDER = Future<EthereumProvider> Function();

enum SafeCreationMode { standard, chainSpecific }

class SafeContractDeployResult {
  final SafeContractController controller;
  final BaseSafeContractEventProxyCreation creationEvent;
  final List<SafeContractEvent> events;
  const SafeContractDeployResult(
      {required this.controller,
      required this.events,
      required this.creationEvent});
}

class SafeContractExecutionResult {
  final TransactionReceipt receipt;
  final List<SafeContractEvent> events;
  SafeContractExecutionResult(
      {required this.receipt, required List<SafeContractEvent> events})
      : events = events.immutable;
}

class SafeTransactionGasParams {
  final BigInt safeTxGas;
  final BigInt baseGas;
  final BigInt gasPrice;
  final ETHAddress gasToken;
  final ETHAddress refundReceiver;
  SafeTransactionGasParams._(
      {required BigInt safeTxGas,
      required BigInt baseGas,
      required BigInt gasPrice,
      required this.gasToken,
      required this.refundReceiver})
      : safeTxGas = safeTxGas.asUint256,
        baseGas = baseGas.asUint256,
        gasPrice = gasPrice.asUint256;
  factory SafeTransactionGasParams(
      {BigInt? safeTxGas,
      BigInt? baseGas,
      BigInt? gasPrice,
      ETHAddress? gasToken,
      ETHAddress? refundReceiver}) {
    return SafeTransactionGasParams._(
        safeTxGas: safeTxGas ?? BigInt.zero,
        baseGas: baseGas ?? BigInt.zero,
        gasPrice: gasPrice ?? BigInt.zero,
        gasToken: gasToken ?? ETHAddress.zero,
        refundReceiver: refundReceiver ?? ETHAddress.zero);
  }
  Map<String, dynamic> toJson() {
    return {
      "safeTxGas": safeTxGas,
      "baseGas": baseGas,
      "gasPrice": gasPrice,
      "gasToken": gasToken,
      "refundReceiver": refundReceiver
    };
  }
}

class SafeTransaction {
  final ETHAddress to;
  final BigInt value;
  final List<int> data;
  final SafeContractExecutionOpration operation;
  final BigInt nonce;
  final SafeTransactionGasParams gasParams;
  Map<String, dynamic> toJson() {
    return {
      "to": to,
      "value": value,
      "data": data,
      "operation": operation.value,
      "nonce": nonce,
      ...gasParams.toJson()
    };
  }

  SafeTransaction._(
      {required this.to,
      required BigInt value,
      required List<int> data,
      required this.operation,
      required BigInt nonce,
      required this.gasParams})
      : value = value.asUint256,
        data = data.asImmutableBytes,
        nonce = nonce.asUint256;
  factory SafeTransaction(
      {required ETHAddress to,
      required BigInt nonce,
      BigInt? value,
      List<int>? data,
      SafeContractExecutionOpration operation =
          SafeContractExecutionOpration.call,
      SafeTransactionGasParams? gasParams}) {
    return SafeTransaction._(
        to: to,
        value: value ?? BigInt.zero,
        data: data ?? <int>[],
        operation: operation,
        nonce: nonce,
        gasParams: gasParams ?? SafeTransactionGasParams());
  }

  List<int> calculateSafeTransactionHash({
    required BigInt chainId,
    required ETHAddress safeAddress,
    required SafeContractVersion version,
  }) {
    return SafeContractUtils.calculateSafeTransactionHash(
        chainId: chainId,
        safeAddress: safeAddress,
        safeTransaction: this,
        version: version);
  }
}

class SafeSignature {
  final ETHAddress address;
  final List<int> signature;
  SafeSignature({required this.address, required List<int> signature})
      : signature = signature
            .exc(CryptoSignerConst.ecdsaSignatureLength +
                CryptoSignerConst.ecdsaRecoveryIdLength)
            .asImmutableBytes;
}

enum SafeTransactionSigningMode { ethSign, signMessage, approveHash }
