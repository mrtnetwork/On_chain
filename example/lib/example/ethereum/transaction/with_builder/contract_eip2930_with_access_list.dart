import 'dart:typed_data';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/ethereum/rpc/socket_service.dart';
import 'package:on_chain/ethereum/ethereum.dart';
import 'package:on_chain/solidity/contract/contract_abi.dart';

import 'abi_1.dart';

void main() async {
  /// Parse the contract ABI from JSON
  final contract = ContractABI.fromJson(polygonAbi2);

  /// Connect to the WebSocket service
  final wsocketService = await RPCWebSocketService.connect(
      "wss://polygon-mumbai-bor.publicnode.com");

  /// Create an Ethereum RPC instance
  final rpc = EthereumProvider(wsocketService);

  /// Define a seed for generating a private key
  final seed = BytesUtils.fromHexString(
      "6fed8bf347b201c4ff0379c9173a042163dbd5f1110bcb983ac8615dcbb98c853f7c1b524dcebdf47e2d19778d0b30e25065d5a5012d83b874ab7034e95a713f");

  /// Derive the BIP44 path for Ethereum
  final bip44 = Bip44.fromSeed(seed, Bip44Coins.ethereum).deriveDefaultPath;

  /// Create an Ethereum private key from the BIP44 private key
  final privateKey = ETHPrivateKey.fromBytes(bip44.privateKey.raw);

  /// Derive the public key and Ethereum address from the private key
  final publicKey = privateKey.publicKey();
  final address = publicKey.toAddress();

  /// Define the contract address
  final contractAddress =
      ETHAddress("0x42865dfd78a2a7c00e6f63746e1ba6da9353edc4");

  /// Build an Ethereum transaction for a contract call
  final tr = ETHTransactionBuilder(
      // Sender's Ethereum address
      from: address,
      // Specify the transaction type (e.g., EIP-2930)
      transactionType: ETHTransactionType.eip2930,
      // Contract address where the call is made
      to: contractAddress,
      data: contract.functionFromName("test5").encode([
        [false, true], // Example boolean parameters
        [
          Uint8List.fromList(
              List<int>.filled(32, 12)), // Example byte array parameter
          Uint8List.fromList(List<int>.filled(69, 17))
        ],
        [address], // Example Ethereum address parameter
        BigInt.from(5) // Example BigInt parameter
      ]),
      // Amount of Ether to be sent with the transaction
      value: BigInt.from(4000),
      // Ethereum chain ID
      chainId: BigInt.from(80001));

  /// Request and set access list for the transaction
  final accessList = await rpc
      .request(EthereumRequestCreateAccessList(transaction: tr.toEstimate()));
  tr.setAccessList(accessList.item1);

  /// Autofill the transaction details using the RPC service
  await tr.autoFill(rpc);

  /// Sign the transaction with the private key
  tr.sign(privateKey);

  /// Get the transaction hash
  final _ = tr.transactionID;

  /// Send and submit the transaction to the Ethereum network
  await tr.submitAndWatchTransactionAsync(rpc);

  /// https://mumbai.polygonscan.com/tx/0x650d3af9a5d979282170f7221fd92215ea54560380d10d71505a9db4186d9cfd
}
