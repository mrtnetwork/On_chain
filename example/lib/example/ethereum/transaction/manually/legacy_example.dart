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

  /// Define the transfer function fragment using ABI
  final transferFragment = AbiFunctionFragment.fromJson({
    "inputs": [
      {"internalType": "address", "name": "to", "type": "address"},
      {"internalType": "uint256", "name": "value", "type": "uint256"}
    ],
    "name": "transfer",
    "stateMutability": "nonpayable",
    "type": "function"
  });

  /// Request gas price from the RPC service
  final gasPrice = await rpc.request(EthereumRequestGetGasPrice());

  /// Request nonce (transaction count) for the sender's address
  final nonce = await rpc
      .request(EthereumRequestGetTransactionCount(address: address.address));

  /// Build an Ethereum transaction for a contract call (transfer)
  ETHTransaction tr = ETHTransaction(
    type: ETHTransactionType.legacy,

    /// Sender's Ethereum address
    from: address,

    /// Target ERC-20 contract address
    to: contractAddress,

    /// Nonce (transaction count) for the sender
    nonce: nonce,

    /// Placeholder for gas limit (to be estimated later)
    gasLimit: BigInt.zero,

    /// Gas price obtained from RPC service (only for legacy and eip2930 transaction)
    gasPrice: gasPrice,

    data: transferFragment.encode([
      /// Recipient address
      ETHAddress("0xBfD365373f559Cd398A408b975FD18B16632d348"),

      /// Amount to transfer (in Wei)
      ETHHelper.toWei("100")
    ]),

    /// No Ether value sent with the transaction
    value: BigInt.zero,

    /// Ethereum chain ID (Mumbai testnet)
    chainId: BigInt.from(80001),
  );

  /// Estimate gas limit for the transaction
  final gasLimit = await rpc.request(EthereumRequestEstimateGas(
    transaction: tr.toEstimate(),
  ));

  /// Update the transaction with the estimated gas limit
  tr = tr.copyWith(gasLimit: gasLimit);

  /// Serialize the unsigned transaction
  final unsignedSerialized = tr.serialized;

  /// Sign the transaction with the private key
  final signature = privateKey.sign(unsignedSerialized);

  /// Serialize the signed transaction
  final signedSerialized =
      BytesUtils.toHexString(tr.signedSerialized(signature), prefix: "0x");

  /// Send the signed transaction to the Ethereum network
  await rpc.request(
      EthereumRequestSendRawTransaction(transaction: signedSerialized));

  /// https://mumbai.polygonscan.com/tx/0xea3863a1f36c939cca63a373d1d8704daa7c62db40535cf388dca3f2c621e430
}
