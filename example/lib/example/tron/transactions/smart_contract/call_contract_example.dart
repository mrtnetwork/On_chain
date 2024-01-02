// ignore_for_file: avoid_print

import 'package:example/example/ethereum/rpc/http_service.dart';
import 'package:on_chain/on_chain.dart';

import 'tron_test_abi.dart';

void main() async {
  /// For Tron: If the output parameters include an address, set isTron to true.
  /// If it doesn't, set isTron to false to receive an ETH address instead of a Tron address.
  final contract = ContractABI.fromJson(tronContract["entrys"]!, isTron: true);
  final rpc = EVMRPC(RPCHttpService("https://api.shasta.trongrid.io/jsonrpc"));
  final call1 = await rpc.request(RPCCall.fromMethod(
      contractAddress:

          /// use hex address (visible to false)
          TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU").toAddress(false),
      function: contract.functionFromName("checkInt"),
      params: [
        BigInt.from(12),
        -BigInt.from(150),
        BigInt.from(25),
        BigInt.from(2),
      ]));
  print("call1 result $call1");
  final call2 = await rpc.request(RPCCall.fromMethod(
      contractAddress:

          /// use hex address (visible to false)
          TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU").toAddress(false),
      function: contract.functionFromName("checkUintList"),
      params: [
        [
          BigInt.from(12),
        ],
        [
          BigInt.from(150),
        ],
        [
          BigInt.from(25),
          BigInt.from(2),
        ]
      ]));
  print("call2 result $call2");
  final call3 = await rpc.request(RPCCall.fromMethod(

      /// use hex address (visible to false)
      contractAddress:
          TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU").toAddress(false),
      function: contract.functionFromName("checkbooli"),
      params: [true]));
  print("call3 result $call3");
  final call4 = await rpc.request(RPCCall.fromMethod(

      /// use hex address (visible to false)
      contractAddress:
          TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU").toAddress(false),
      function: contract.functionFromName("checkboolis"),
      params: [
        [true, false, false, true]
      ]));
  print("call4 result $call4");
  final call5 = await rpc.request(RPCCall.fromMethod(

      /// use hex address (visible to false)
      contractAddress:
          TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU").toAddress(false),
      function: contract.functionFromName("checkbyte"),
      params: [List<int>.filled(65, 12)]));
  print("call5 result $call5");
  final call6 = await rpc.request(RPCCall.fromMethod(

      /// use hex address (visible to false)
      contractAddress:
          TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU").toAddress(false),
      function: contract.functionFromName("checkbytest"),
      params: [
        [
          List<int>.filled(3, 12),
          List<int>.filled(4, 15),
          List<int>.filled(5, 20),
        ]
      ]));
  print("call5 result $call6");
  final call7 = await rpc.request(RPCCall.fromMethod(

      /// use hex address (visible to false)
      contractAddress:
          TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU").toAddress(false),
      function: contract.functionFromName("listAddress"),
      params: [
        [TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU")]
      ]));
  print("call7 result $call7");
}
