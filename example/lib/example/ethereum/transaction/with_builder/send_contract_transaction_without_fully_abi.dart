import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/ethereum/rpc/socket_service.dart';
import 'package:on_chain/on_chain.dart';

void main() async {
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

  /// Define the target ERC-20 contract address
  final contractAddress =
      ETHAddress("0x6c6b4fd6502c74ed8a15d54b9152973f3aa24e51");

  final transferFragment = AbiFunctionFragment.fromJson({
    "inputs": [
      {"internalType": "address", "name": "to", "type": "address"},
      {"internalType": "uint256", "name": "value", "type": "uint256"}
    ],
    "name": "transfer",
    "stateMutability": "nonpayable",
    "type": "function"
  });

  /// Build an Ethereum transaction for a contract call (transfer)
  final tr = ETHTransactionBuilder.contract(

      /// Sender's Ethereum address
      from: address,

      /// Transaction type (EIP-2930)
      transactionType: ETHTransactionType.eip2930,

      /// Target ERC-20 contract address
      contractAddress: contractAddress,

      /// Function to call (transfer)
      function: transferFragment,
      functionParams: [
        /// Recipient address
        ETHAddress("0xBfD365373f559Cd398A408b975FD18B16632d348"),

        /// Amount to transfer (in Wei)
        ETHHelper.toWei("100")
      ],

      /// No Ether value sent with the transaction
      value: BigInt.zero,
      chainId: BigInt.from(80001));

  /// Ethereum chain ID (Mumbai testnet)

  /// Autofill the transaction details using the RPC service
  await tr.autoFill(rpc);

  /// Sign the transaction with the private key
  tr.sign(privateKey);

  /// Get the transaction hash
  final _ = tr.transactionID;

  /// Send and submit the transaction to the Ethereum network
  await tr.sendAndSubmitTransaction(rpc);

  /// https://mumbai.polygonscan.com/tx/0x13fff87386176a18a0d7f2e324991be48362d81fb5838a1914ce9ccf6f499745
}
