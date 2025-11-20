import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/transaction/eth_transaction.dart';
import 'package:on_chain/solidity/abi/abi.dart';

class ZksyncUtils {
  static const eip712TxTypes = [
    Eip712TypeDetails(name: 'txType', type: 'uint256'),
    Eip712TypeDetails(name: 'from', type: 'uint256'),
    Eip712TypeDetails(name: 'to', type: 'uint256'),
    Eip712TypeDetails(name: 'gasLimit', type: 'uint256'),
    Eip712TypeDetails(name: 'gasPerPubdataByteLimit', type: 'uint256'),
    Eip712TypeDetails(name: 'maxFeePerGas', type: 'uint256'),
    Eip712TypeDetails(name: 'maxPriorityFeePerGas', type: 'uint256'),
    Eip712TypeDetails(name: 'paymaster', type: 'uint256'),
    Eip712TypeDetails(name: 'nonce', type: 'uint256'),
    Eip712TypeDetails(name: 'value', type: 'uint256'),
    Eip712TypeDetails(name: 'data', type: 'bytes'),
    Eip712TypeDetails(name: 'factoryDeps', type: 'bytes32[]'),
    Eip712TypeDetails(name: 'paymasterInput', type: 'bytes'),
  ];
  static Eip712TypedData getTypeData(
      {required BigInt chainId,
      required ETHAddress? from,
      required ETHAddress? to,
      required BigInt gasLimit,
      required BigInt maxFeePerGas,
      required int nonce,
      required ZKSyncE712Parameters zkParams,
      ETHTransactionType type = ETHTransactionType.eip712,
      Map<String, dynamic>? eip712Domain,
      BigInt? maxPriorityFeePerGas,
      BigInt? value,
      List<int>? data}) {
    return Eip712TypedData(
        types: {
          "Transaction": eip712TxTypes,
        },
        primaryType: "Transaction",
        domain: eip712Domain ??
            {"name": "zkSync", "version": "2", "chainId": chainId},
        message: {
          "txType": type.prefix,
          "from": from?.toBigInt() ?? BigInt.zero,
          "to": to?.toBigInt() ?? BigInt.zero,
          "gasLimit": gasLimit,
          "maxFeePerGas": maxFeePerGas,
          "nonce": nonce,
          "maxPriorityFeePerGas": maxPriorityFeePerGas ?? BigInt.zero,
          "data": data ?? <int>[],
          "value": value ?? BigInt.zero,
          "factoryDeps": zkParams.factoryDeps,
          "gasPerPubdataByteLimit": zkParams.gasPerPubdata,
          "paymaster": zkParams.paymaster?.address.toBigInt() ?? BigInt.zero,
          "paymasterInput": zkParams.paymaster?.input ?? <int>[]
        });
  }
}

class ZKSyncPaymaster {
  final ETHAddress address;
  final List<int> input;
  ZKSyncPaymaster({required this.address, required List<int> input})
      : input = input.asImmutableBytes;
  List<List<dynamic>> serialize() {
    return [address.toBytes(), input];
  }

  Map<String, dynamic> toJson() {
    return {
      "paymaster": address.address,
      "paymasterInput": BytesUtils.toHexString(input, prefix: "0x")
    };
  }
}

class ZKSyncE712Parameters {
  final BigInt gasPerPubdata;
  final List<List<int>> factoryDeps;
  final ZKSyncPaymaster? paymaster;
  ZKSyncE712Parameters(
      {required this.gasPerPubdata,
      required List<List<int>> factoryDeps,
      this.paymaster})
      : factoryDeps = factoryDeps.map((e) => e.asImmutableBytes).toImutableList;
  List<List<dynamic>> serialize() {
    return [
      ETHTransactionUtils.bigintToBytes(gasPerPubdata),
      factoryDeps,
      paymaster?.serialize() ?? []
    ];
  }
}
