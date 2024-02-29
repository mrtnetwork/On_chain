import 'package:example/example/solana/quick_wallet_for_testing/quick_wallet.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  final owner = QuickWalletForTest(index: 406);
  final account1 = QuickWalletForTest(index: 405);
  final account3 = QuickWalletForTest(index: 407);
  final account5 = QuickWalletForTest(index: 408);
  SolAddress blockHash = await owner.recentBlockhash();
  final program = SystemProgram.createAccount(
      from: owner.address,
      newAccountPubKey: account5.address,
      layout: SystemCreateLayout(
          lamports: SolanaUtils.toLamports("0.1"),
          space: StakeProgramConst.stakeProgramSpace,
          programId: StakeProgramConst.programId));
  final initialize = StakeProgram.initialize(
      layout: StakeInitializeLayout(
          authorized: StakeAuthorized(
              staker: account1.address, withdrawer: account3.address)),
      stakePubkey: account5.address);

  final SolanaTransaction transaction = SolanaTransaction(
      instructions: [program, initialize],
      recentBlockhash: blockHash,
      payerKey: owner.address,
      type: TransactionType.v0);
  transaction.sign([owner.privateKey, account5.privateKey]);
  final ser = transaction.serializeString();
  await owner.submitTr(ser);

  /// https://explorer.solana.com/tx/hj3LNM6oC1fnvxMnykBgkZwcnsG1RSX9cgCWVyJA5obSjcrkw81BrRHHiGgVSvfVfbrEKhp4pTC6ZtjkxycWHg1?cluster=devnet
}
