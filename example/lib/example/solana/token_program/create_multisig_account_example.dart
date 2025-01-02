import 'package:example/example/solana/quick_wallet_for_testing/quick_wallet.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  final owner = QuickWalletForTest(index: 450);

  final account1 = QuickWalletForTest(index: 451);
  final account3 = QuickWalletForTest(index: 452);
  final account5 = QuickWalletForTest(index: 453);
  final account6 = QuickWalletForTest(index: 454);
  final account7 = QuickWalletForTest(index: 455);
  final account8 = QuickWalletForTest(index: 456);
  final lamports = await QuickWalletForTest.rpc.request(
      SolanaRequestGetMinimumBalanceForRentExemption(
          size: SolanaMultiSigAccountUtils.multisigSize));
  final account = SystemProgram.createAccount(
      from: owner.address,
      newAccountPubKey: account1.address,
      layout: SystemCreateLayout(
          lamports: lamports,
          space: BigInt.from(SolanaMultiSigAccountUtils.multisigSize),
          programId: SPLTokenProgramConst.tokenProgramId));
  final multisigInstruction = SPLTokenProgram.initializeMultisig(
      layout: SPLTokenInitializeMultisigLayout(numberOfRequiredSignatures: 5),
      account: account1.address,
      signers: [
        account3.address,
        account5.address,
        account6.address,
        account7.address,
        account8.address
      ]);

  final tr = SolanaTransaction(
      payerKey: owner.address,
      instructions: [account, multisigInstruction],
      recentBlockhash: await owner.recentBlockhash(),
      type: TransactionType.v0);

  tr.sign([owner.privateKey, account1.privateKey]);

  await owner.submitTr(tr.serializeString());

  /// https://explorer.solana.com/tx/3CREicMdf33YMirWXz35gqA7RBeM3y2fmh4iqP8ZmspiahiMtNd1mczozB5o1ZUp79zB8EJhPjjDrEnwUYy7VY8L?cluster=devnet
}
