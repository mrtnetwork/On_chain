// ignore_for_file: unused_local_variable

import 'package:on_chain/ethereum/ethereum.dart';

import 'http_service.dart';
import 'socket_service.dart';

void main() async {
  /// HTTP RPC Service
  final httpRpc = RPCHttpService("https://bsc-testnet.drpc.org/");
// Initialize an HTTP RPC service for interacting with the Binance Smart Chain (BSC) testnet.

  /// WebSocket RPC Service
  final websocketRpc = await RPCWebSocketService.connect(
      "wss://go.getblock.io/b9c91d92aaeb4e5ba2d4cca664ab708c",
      onEvents: (p0) {},
      onClose: (p0) {});
// Establish a WebSocket RPC connection to the specified endpoint for real-time updates.

  /// Ethereum RPC
  final rpc = EthereumProvider(httpRpc);
// Create an Ethereum RPC instance using the HTTP RPC service.

  /// Get Balance
  final balance = await rpc.request(EthereumRequestGetBalance(
      address:
          ETHAddress("0x7Fbb78c66505876284a49Ad89BEE3df2e0B7ca5E").address));
// Request the balance of a specific Ethereum address using the RPC service.

  /// Get Block
  final block = await rpc.request(
      EthereumRequestGetBlockByNumber(blockNumber: BlockTagOrNumber.latest));
// Request information about the latest Ethereum block using the RPC service.

  /// Contract Call
  final call = await rpc.request(
      EthereumRequestCall.fromRaw(contractAddress: ".....", raw: "raw"));
// Make a contract call using the RPC service, specifying the contract address and raw data.

  /// Methods Reference
  /// Explore all available methods in the ethereum/rpc/methods/ directory.
  /// These methods encapsulate various Ethereum RPC calls for convenient usage.
}
