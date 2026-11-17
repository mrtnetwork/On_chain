// ignore_for_file: unused_local_variable

import 'package:blockchain_utils/exception/exceptions.dart';
import 'package:example/example/contract/abi.dart';
import 'package:example/example/ethereum/rpc/http_service.dart';
import 'package:on_chain/on_chain.dart';

void main() async {
// Parse the contract ABI from JSON using the abiTest data
  final contract = ContractABI.fromJson(abiTest);

// Create an Ethereum RPC instance with a HTTP service on the Polygon Mumbai testnet
  final rpc = EthereumProvider(
      RPCHttpService("https://polygon-mumbai-bor.publicnode.com"));

// Make an RPC call to execute a method on the contract and get the result
  final call1 = await rpc.request(EthereumRequestFunctionCall(
    contractAddress: "0xf16a88bb679fcda0672aa27a12b159ecc4ae7374",
    function: contract.functionFromName("checkInt"),
    params: [
      BigInt.from(12),
      BigInt.from(150),
      BigInt.from(25),
      BigInt.from(2),
    ],
  ));

// Similar RPC call for another method on the contract
  final call2 = await rpc.request(EthereumRequestFunctionCall(
    contractAddress: "0xf16a88bb679fcda0672aa27a12b159ecc4ae7374",
    function: contract.functionFromName("checkuInt"),
    params: [
      BigInt.from(12),
      BigInt.from(150),
      BigInt.from(25),
      BigInt.from(2),
    ],
  ));

// RPC call for a method that involves a list of Ethereum addresses
  final call3 = await rpc.request(EthereumRequestFunctionCall(
    contractAddress: "0xf16a88bb679fcda0672aa27a12b159ecc4ae7374",
    function: contract.functionFromName("listAddress"),
    params: [
      [
        ETHAddress("0xf16a88bb679fcda0672aa27a12b159ecc4ae7374"),
        ETHAddress("0xf16a88bb679fcda0672aa27a12b159ecc4ae7374"),
        ETHAddress("0xf16a88bb679fcda0672aa27a12b159ecc4ae7374"),
        ETHAddress("0xf16a88bb679fcda0672aa27a12b159ecc4ae7374"),
      ],
    ],
  ));

// RPC call for a method that involves a list of byte arrays
  final call4 = await rpc.request(EthereumRequestFunctionCall(
    contractAddress: "0xf16a88bb679fcda0672aa27a12b159ecc4ae7374",
    function: contract.functionFromName("checkbytest"),
    params: [
      [
        List<int>.filled(5, 21),
        List<int>.filled(6, 22),
        List<int>.filled(6, 23),
      ],
    ],
  ));

// RPC call for a method that involves a single byte array
  final call5 = await rpc.request(EthereumRequestFunctionCall(
    contractAddress: "0xf16a88bb679fcda0672aa27a12b159ecc4ae7374",
    function: contract.functionFromName("checkbyte"),
    params: [
      List<int>.filled(6, 77),
    ],
  ));

// RPC call for a method that involves a single byte array of length 32
  final call6 = await rpc.request(EthereumRequestFunctionCall(
    contractAddress: "0xf16a88bb679fcda0672aa27a12b159ecc4ae7374",
    function: contract.functionFromName("checkbyte32"),
    params: [
      List<int>.filled(32, 78),
    ],
  ));

// RPC call for a method that involves a boolean parameter
  final call7 = await rpc.request(EthereumRequestFunctionCall(
    contractAddress: "0xf16a88bb679fcda0672aa27a12b159ecc4ae7374",
    function: contract.functionFromName("checkbooli"),
    params: [true],
  ));

// Attempting an RPC call that is expected to raise an error, catch the error and decode it
  try {
    final call8 = await rpc.request(EthereumRequestFunctionCall(
      contractAddress: "0xf16a88bb679fcda0672aa27a12b159ecc4ae7374",
      function: contract.functionFromName("checkError"),
      params: [],
    ));
  } on RPCError catch (e) {
    final data = e.details?["data"];
    if (data != null) {
      final revertErrors = contract.decodeError(data);
    }
  }

// Another RPC call expected to raise an error, catch the error and decode it
  try {
    final call9 = await rpc.request(EthereumRequestFunctionCall(
      contractAddress: "0xf16a88bb679fcda0672aa27a12b159ecc4ae7374",
      function: contract.functionFromName("checkErrorValue1"),
      params: [
        BigInt.one,
        [
          BigInt.from(12222222222222),
          BigInt.from(12222222222222),
        ]
      ],
    ));
  } on RPCError catch (e) {
    final data = e.details?["data"];
    if (data != null) {
      final revertErrors = contract.decodeError(data);
    }
  }

// Retrieve the function information for a specific function name
  final ei = contract.functionFromName("checkbooli");
}
