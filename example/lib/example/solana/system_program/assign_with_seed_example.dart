import 'package:example/example/solana/quick_wallet_for_testing/quick_wallet.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  final owner = QuickWalletForTest(index: 255);
  const String seed = "account1";
  final blockHash = await owner.recentBlockhash();
  final layout = SystemAssignWithSeedLayout(
      programId: SystemProgramConst.programId, base: owner.address, seed: seed);

  final create = SystemProgram.assignWithSeed(
      layout: layout,
      account: SolAddress.withSeed(
          fromPublicKey: owner.address,
          seed: seed,
          programId: SystemProgramConst.programId));

  final SolanaTransaction transaction = SolanaTransaction(
      instructions: [create],
      recentBlockhash: blockHash,
      payerKey: owner.address,
      type: TransactionType.legacy);

  final ownerSignature = owner.privateKey.sign(transaction.serializeMessage());
  transaction.addSignature(owner.address, ownerSignature);
  final ser = transaction.serializeString();
  await owner.submitTr(ser);

  /// https://explorer.solana.com/tx/4hF8qGxX6mjJEhME8Sn9LfgyJuTBVDN3pVLB3PUUXcH6oSaKFnmigotDFAsDzYnHrjP5tej5oPN88Sb3GSm7hGmG?cluster=devnet
}
