import 'package:example/example/solana/quick_wallet_for_testing/quick_wallet.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  final wallet = QuickWalletForTest(index: 1100);
  final mintAccount = QuickWalletForTest(index: 1111);

  final associatedTokenAccount =
      AssociatedTokenAccountProgramUtils.associatedTokenAccount(
          mint: mintAccount.address, owner: wallet.address);

  final createAssociatedTokenAccount =
      AssociatedTokenAccountProgram.associatedTokenAccount(
          payer: wallet.address,
          associatedToken: associatedTokenAccount.address,
          owner: wallet.address,
          mint: mintAccount.address);

  final tr = SolanaTransaction(
      payerKey: wallet.address,
      instructions: [createAssociatedTokenAccount],
      recentBlockhash: await wallet.recentBlockhash());
  tr.sign([wallet.privateKey]);
  await wallet.submitTr(tr.serializeString());

  /// https://explorer.solana.com/tx/BTdjhKHYKcKFSNdxQXG617JUXbMGnZs54aWZyKGsiPTh6Z6f8Qe1WMZQGD7BbBjfrFrjEmdU8HyQQ9NRQmZHWUP?cluster=testnet
}
