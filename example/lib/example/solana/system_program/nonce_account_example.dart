import 'package:example/example/solana/quick_wallet_for_testing/quick_wallet.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  final owner = QuickWalletForTest(index: 255);
  final nonceAccount = QuickWalletForTest(index: 300);
  final layout = SystemInitializeNonceAccountLayout(authorized: owner.address);
  final newAccountInstraction = SystemProgram.createAccount(
      from: owner.address,
      newAccountPubKey: nonceAccount.address,
      layout: SystemCreateLayout(
          lamports: SolanaUtils.toLamports("0.1"),
          space: BigInt.from(80),
          programId: SystemProgramConst.programId));
  final blockHash = await owner.recentBlockhash();
  final create = SystemProgram.nonceInitialize(
      layout: layout, noncePubKey: nonceAccount.address);
  final SolanaTransaction transaction = SolanaTransaction(
      instructions: [newAccountInstraction, create],
      recentBlockhash: blockHash,
      payerKey: owner.address,
      type: TransactionType.legacy);
  transaction.sign([nonceAccount.privateKey, owner.privateKey]);
  final ser = transaction.serializeString();
  await owner.submitTr(ser);

  /// https://explorer.solana.com/tx/4HGVL8fBVuB6uh2ExgL6s9GW7Bx8ziAAWairTCWZw17vL8ytbhG2wm7Y7poHNqAvMKtb95tvHsMLwg31VfDPNPZ?cluster=devnet
}
