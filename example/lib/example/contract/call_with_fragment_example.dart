// ignore_for_file: unused_local_variable

import 'package:example/example/contract/abi.dart';
import 'package:example/example/ethereum/rpc/http_service.dart';
import 'package:on_chain/on_chain.dart';

void main() async {
// Parse the contract ABI from JSON using the abiTest data
  final contract = ContractABI.fromJson(abiTest);

// Create an Ethereum RPC instance with a HTTP service on the Polygon Mumbai testnet
  final rpc =
      EVMRPC(RPCHttpService("https://polygon-mumbai-bor.publicnode.com"));

// Make an RPC call to execute a method on the contract and get the result
  final call1 = await rpc.request(RPCCall.fromMethod(
    contractAddress: "0xf16a88bb679fcda0672aa27a12b159ecc4ae7374",
    function: AbiFunctionFragment.fromJson({
      "inputs": [
        {"internalType": "int64", "name": "is64", "type": "int64"},
        {"internalType": "int128", "name": "is128", "type": "int128"},
        {"internalType": "int256", "name": "is256", "type": "int256"},
        {"internalType": "int8", "name": "is8", "type": "int8"}
      ],
      "name": "checkInt",
      "outputs": [
        {"internalType": "int64", "name": "", "type": "int64"},
        {"internalType": "int128", "name": "", "type": "int128"},
        {"internalType": "int256", "name": "", "type": "int256"},
        {"internalType": "int8", "name": "", "type": "int8"}
      ],
      "stateMutability": "pure",
      "type": "function"
    }, false),
    params: [
      BigInt.from(12),
      BigInt.from(150),
      BigInt.from(25),
      BigInt.from(2),
    ],
  ));
}
