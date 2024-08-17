import 'package:example/example/solana/quick_wallet_for_testing/quick_wallet.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  final wallet = QuickWalletForTest(index: 1100);
  final freezeAuthority = QuickWalletForTest(index: 1112);
  final mintAccount = QuickWalletForTest(index: 1111);
  final mintAccSpace = SolanaMintAccount.size;

  final rent = await QuickWalletForTest.rpc
      .request(SolanaRPCGetMinimumBalanceForRentExemption(size: mintAccSpace));
  final createAccount = SystemProgram.createAccount(
      from: wallet.address,
      newAccountPubKey: mintAccount.address,
      layout: SystemCreateLayout(
          lamports: rent,
          space: BigInt.from(mintAccSpace),
          programId: SPLTokenProgramConst.tokenProgramId));

  final mint = SPLTokenProgram.initializeMint2(
      layout: SPLTokenInitializeMint2Layout(
          mintAuthority: wallet.address,
          decimals: 3,
          freezeAuthority: freezeAuthority.address),
      mint: mintAccount.address);
  final tr = SolanaTransaction(
      payerKey: wallet.address,
      instructions: [createAccount, mint],
      recentBlockhash: await wallet.recentBlockhash());
  tr.sign([wallet.privateKey, mintAccount.privateKey]);
  await wallet.submitTr(tr.serializeString());

  /// https://explorer.solana.com/tx/mdjLvhvVUqfBKnmmCRAsmAjXGZsxEWMw7vvZMfT512rjeydmfgDfdX8YZmTjbvxNVqGbSBScedxAGXzfF3GLceR?cluster=testnet
}
