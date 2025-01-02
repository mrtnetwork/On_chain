import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/ethereum/rpc/socket_service.dart';
import 'package:on_chain/ethereum/ethereum.dart';

void main() async {
  /// Connect to the WebSocket service
  final wsocketService = await RPCWebSocketService.connect(
      "wss://polygon-mumbai-bor.publicnode.com");

  /// Create an Ethereum RPC instance
  final rpc = EthereumProvider(wsocketService);

  /// Define a seed for generating a private key
  final seed = BytesUtils.fromHexString(
      "6fed8bf347b201c4ff0379c9173a042163dbd5f1110bcb983ac8615dcbb98c853f7c1b524dcebdf47e2d19778d0b30e25065d5a5012d83b874ab7034e95a713f");

  /// Generate a BIP44 key from the seed for Ethereum
  final bip44 = Bip44.fromSeed(seed, Bip44Coins.ethereum);

  /// Create an Ethereum private key from the BIP44 private key
  final privateKey = ETHPrivateKey.fromBytes(bip44.privateKey.raw);

  /// Derive the public key and Ethereum address from the private key
  final publicKey = privateKey.publicKey();
  final address = publicKey.toAddress();

  /// Define the recipient's Ethereum address
  final receiverAddress =
      ETHAddress("0xBfD365373f559Cd398A408b975FD18B16632d348");

  /// Build an Ethereum transaction
  final tr = ETHTransactionBuilder(

      ///  set transaction type to eip2930 (Berlin hard fork)
      transactionType: ETHTransactionType.eip2930,

      /// from
      from: address,

      /// receipt
      to: receiverAddress,

      /// memo
      memo: "https://github.com/mrtnetwork",

      /// value /// 0.0000001 MATIC
      value: ETHHelper.toWei("0.0000001"),

      /// chain ID
      chainId: BigInt.from(80001));

  /// Autofill the transaction details using the RPC service
  await tr.autoFill(rpc);

  /// Sign the transaction with the private key
  tr.sign(privateKey);

  /// Get the transaction hash
  final _ = tr.transactionID;

  /// Send and submit the transaction to the Ethereum network
  await tr.sendAndSubmitTransaction(rpc);

  /// https://mumbai.polygonscan.com/tx/0xfb9f629f9f2095ea0e8df7c2b864075daa96fd411e3a8329b5da81c6e9fe3d0d
}
