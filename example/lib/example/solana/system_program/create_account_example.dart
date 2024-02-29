import 'package:example/example/solana/quick_wallet_for_testing/quick_wallet.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  final owner = QuickWalletForTest(index: 255);
  final newAccount = QuickWalletForTest(index: 256);
  final blockHash = await owner.recentBlockhash();
  final create = SystemProgram.createAccount(
      from: owner.address,
      newAccountPubKey: newAccount.address,
      layout: SystemCreateLayout(
          lamports: BigInt.from(250000000),
          programId: SystemProgramConst.programId,
          space: BigInt.from(200)));

  final SolanaTransaction transaction = SolanaTransaction(
      instructions: [create],
      recentBlockhash: blockHash,
      payerKey: owner.address,
      type: TransactionType.v0);

  transaction.sign([owner.privateKey, newAccount.privateKey]);
  final ser = transaction.serializeString();
  await owner.submitTr(ser);

  /// https://explorer.solana.com/tx/TAwtGN5VB5SZ3s4Rx7ZGkvMsp4um7UyT4ES9P54Pe7RD62x8fTLFQau1iX6yLxNbZGFjAoPr4wXmkkCx1WGc43X?cluster=devnet
}
