import 'dart:typed_data';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/ethereum/rpc/socket_service.dart';
import 'package:on_chain/on_chain.dart';

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
  final tr = ETHTransactionBuilder.contract(
      // Sender's Ethereum address
      from: address,
      // Specify the transaction type (e.g., EIP-1559)
      transactionType: ETHTransactionType.eip1559,
      // Contract address where the call is made
      contractAddress: contractAddress,
      // Contract function to be called
      function: contract.functionFromName("test5"),
      // Parameters for the contract function
      functionParams: [
        [false, true], // Example boolean parameters bool[]
        [
          // Example byte array parameter bytes[]
          Uint8List.fromList(List<int>.filled(32, 12)),
          Uint8List.fromList(List<int>.filled(69, 17))
        ],
        [address], // Example Ethereum address[] parameter
        BigInt.from(5) // Example uint256 parameter
      ],
      // Amount of Ether to be sent with the transaction
      value: BigInt.from(4000),
      // Ethereum chain ID
      chainId: BigInt.from(80001));

  /// Autofill the transaction details using the RPC service
  await tr.autoFill(rpc);

  /// Sign the transaction with the private key
  tr.sign(privateKey);

  /// Get the transaction hash
  final _ = tr.transactionID;

  /// Send and submit the transaction to the Ethereum network
  await tr.sendAndSubmitTransaction(rpc);

  /// https://mumbai.polygonscan.com/tx/0x4d9f4c7080bd7c14d243346820e669be9bc95318c10546959dd1ae804d83be15
}
