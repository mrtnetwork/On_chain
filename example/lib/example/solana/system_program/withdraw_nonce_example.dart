import 'package:example/example/solana/quick_wallet_for_testing/quick_wallet.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  final owner = QuickWalletForTest(index: 255);
  final nonceAccount = QuickWalletForTest(index: 300);
  final receiver = QuickWalletForTest(index: 301);
  SolAddress blockHash = await owner.recentBlockhash();
  final layout = SystemWithdrawNonceLayout(lamports: BigInt.from(10000000));

  final program = SystemProgram.nonceWithdraw(
      authorizedPubkey: owner.address,
      noncePubKey: nonceAccount.address,
      layout: layout,
      toPubKey: receiver.address);

  final SolanaTransaction transaction = SolanaTransaction(
      instructions: [program],
      recentBlockhash: blockHash,
      payerKey: owner.address,
      type: TransactionType.v0);
  transaction.sign([owner.privateKey]);
  final ser = transaction.serializeString();
  await owner.submitTr(ser);

  /// https://explorer.solana.com/tx/gsqqiwBLisKpqa41u89GppKurA87T81UVacZShzigKgjF66im48yiR2aikEPcdvQmfZvBPYXvhFX4aomZcQNXn6?cluster=devnet
}
