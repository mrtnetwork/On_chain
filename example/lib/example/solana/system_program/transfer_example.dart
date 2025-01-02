import 'package:example/example/solana/service_example/service_example.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  /// Set up the RPC service with the Solana devnet endpoint.
  final service = RPCHttpService("https://api.devnet.solana.com");

  /// Initialize the Solana RPC client.
  final rpc = SolanaProvider(service);

  /// Define the owner's private key and derive the owner's public key.
  final ownerPrivateKey = SolanaPrivateKey.fromSeedHex(
      "4e27902b3df33d7857dc9d218a3b34a6550e9c7621a6d601d06240a517d22017");
  final owner = ownerPrivateKey.publicKey().toAddress();

  /// Define the recipient's address.
  final receiver = SolAddress("9eaiUBgyT7EY1go2qrCmdRZMisYkGdtrrem3TgP9WSDb");

  /// Retrieve the latest block hash.
  final blockHash = await rpc.request(const SolanaRequestGetLatestBlockhash());

  /// Create a transfer instruction to move funds from the owner to the receiver.
  final transferInstruction = SystemProgram.transfer(
      from: owner,
      layout: SystemTransferLayout(lamports: SolanaUtils.toLamports("0.001")),
      to: receiver);

  /// Construct a Solana transaction with the transfer instruction.
  final transaction = SolanaTransaction(
      instructions: [transferInstruction],
      recentBlockhash: blockHash.blockhash,
      payerKey: owner,
      type: TransactionType.v0);

  /// Sign the transaction with the owner's private key.
  final ownerSignature = ownerPrivateKey.sign(transaction.serializeMessage());
  transaction.addSignature(owner, ownerSignature);

  /// Serialize the transaction.
  final serializedTransaction = transaction.serializeString();

  /// Send the transaction to the Solana network.
  await rpc.request(
      SolanaRequestSendTransaction(encodedTransaction: serializedTransaction));

  /// https://explorer.solana.com/tx/iXm4f9ZUqBF3Mcp6bFvLSU55pqP7VCiRxNABD4DPVsjwVW5KfgbxbftMYzXTfJhoQyaXywBXxo6btjbhA1GtNqB?cluster=devnet
}
