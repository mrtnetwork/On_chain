import 'package:example/example/solana/quick_wallet_for_testing/quick_wallet.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  final owner = QuickWalletForTest(index: 255);
  final nonceAccount = QuickWalletForTest(index: 300);

  SolAddress blockHash = await owner.recentBlockhash();
  final program = SystemProgram.nonceAdvance(
      authorizedPubkey: owner.address, noncePubKey: nonceAccount.address);

  final SolanaTransaction transaction = SolanaTransaction(
      instructions: [program],
      recentBlockhash: blockHash,
      payerKey: owner.address,
      type: TransactionType.legacy);
  transaction.sign([owner.privateKey]);
  final ser = transaction.serializeString();
  await owner.submitTr(ser);

  /// https://explorer.solana.com/tx/UUegYgfZJ4KtPEwdoSwA2J3vKtGBgwP6CZnN65MZGcJnBKn9JMuemtxYdLpdxTmJ2YmUn3aN77uCDd5Qj8BeCjj?cluster=devnet
}
