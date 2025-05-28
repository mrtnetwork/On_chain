// ignore_for_file: avoid_print

import 'package:example/example/tron/provider_service/provider_service.dart';
import 'package:on_chain/on_chain.dart';

import 'tron_test_abi.dart';

void main() async {
  /// For Tron: If the output parameters include an address, set isTron to true.
  /// If it doesn't, set isTron to false to receive an ETH address instead of a Tron address.
  final contract = ContractABI.fromJson(tronContract["entrys"]!);
  final rpc =
      TronProvider(TronHTTPProvider(url: "https://api.shasta.trongrid.io"));
  final call1 = await rpc.request(TronRequestTriggerConstantContract.fromMethod(
    ownerAddress: TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU"),
    contractAddress: TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU"),
    function: contract.functionFromName("checkInt"),

    /// trx amount in call
    callValue: null,

    /// trc10 amount and token id in call
    callTokenValue: null,
    tokenId: null,

    params: [
      -BigInt.from(12),
      -BigInt.from(150),
      BigInt.from(25),
      BigInt.from(2),
    ],
  ));
  print("call1 result ${call1.outputResult}");
  final call2 = await rpc.request(TronRequestTriggerConstantContract.fromMethod(
    ownerAddress: TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU"),
    contractAddress: TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU"),
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
    ],
  ));
  print("call2 result ${call2.outputResult}");

  final call3 = await rpc.request(TronRequestTriggerConstantContract.fromMethod(
    ownerAddress: TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU"),
    contractAddress: TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU"),
    function: contract.functionFromName("checkbooli"),
    params: [true],
  ));
  print("call3 result ${call3.outputResult}");
  final call4 = await rpc.request(TronRequestTriggerConstantContract.fromMethod(
    ownerAddress: TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU"),
    contractAddress: TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU"),
    function: contract.functionFromName("listAddress"),
    params: [
      [TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU")]
    ],
  ));
  print("call4 result ${call4.outputResult}");

  /// manually call
  final func = contract.functionFromName("listAddress");
  final params = [
    [TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU")]
  ];
  final call5 = await rpc.request(TronRequestTriggerConstantContract(
    ownerAddress: TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU"),
    contractAddress: TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU"),

    /// use function selector and parameter (encode params without selector 4bytes)
    functionSelector: func.functionName,
    parameter: func.encodeHex(params, false),

    /// or use data (encode params with selector)
    // data: func.encodeHex(params, true),
  ));
  final result = call5.constantResult[0];
  final decodeOutput = func.decodeOutputHex(result);
  print("call5 result $decodeOutput");
}
