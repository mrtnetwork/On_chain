import 'package:example/example/solana/quick_wallet_for_testing/quick_wallet.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  final wallet = QuickWalletForTest(index: 1100);
  final mintAccount = QuickWalletForTest(index: 1111);
  final owner = SolAddress("6fLggs5D6iwCMwB5a2Scd3gqPYcvtpvWpFb4LXFQ89Bz");
  final destinationTokenAccount =
      AssociatedTokenAccountProgramUtils.associatedTokenAccount(
          mint: mintAccount.address, owner: owner);
  final createAssociatedTokenAccount = SPLTokenProgram.mintTo(
      mint: mintAccount.address,
      destination: destinationTokenAccount.address,
      authority: wallet.address,
      layout: SPLTokenMintToLayout(amount: BigInt.from(123456455345234234)));
  final tr = SolanaTransaction(
      payerKey: wallet.address,
      instructions: [createAssociatedTokenAccount],
      recentBlockhash: await wallet.recentBlockhash());
  tr.sign([wallet.privateKey]);
  await wallet.submitTr(tr.serializeString());

  /// https://explorer.solana.com/tx/3BWNp5nkcwQz786WVfZmnTdhiE7c11Sef7YfhmPvmKYWbpp5KEcnYSLwm8xwqK4y2ufgRVHpwiWR39gDR4JYALH8?cluster=testnet
}
