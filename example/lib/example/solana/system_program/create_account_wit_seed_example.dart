import 'package:example/example/solana/quick_wallet_for_testing/quick_wallet.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  final owner = QuickWalletForTest(index: 255);
  const String seed = "account1";
  final blockHash = await owner.recentBlockhash();
  final layout = SystemCreateWithSeedLayout(
      lamports: BigInt.from(250000000),
      programId: SystemProgramConst.programId,
      space: BigInt.from(200),
      seed: seed,
      base: owner.address);

  final create = SystemProgram.createAccountWithSeed(
      from: owner.address,
      baseAccount: owner.address,
      newAccount: SolAddress.withSeed(
          fromPublicKey: owner.address,
          seed: seed,
          programId: SystemProgramConst.programId),
      layout: layout);

  final SolanaTransaction transactionV0 = SolanaTransaction(
      instructions: [create],
      recentBlockhash: blockHash,
      payerKey: owner.address,
      type: TransactionType.legacy);

  final ownerSignature =
      owner.privateKey.sign(transactionV0.serializeMessage());

  transactionV0.addSignature(owner.address, ownerSignature);

  final ser = transactionV0.serializeString();
  await owner.submitTr(ser);

  /// https://explorer.solana.com/tx/3yPoh2q9j3JSkQK1i9Z64Ban7Cq8E3FabKMpYMPuWxLbGdydAjftM59dkLmLwirBFnqQ2GDExvo7vsdoQeeRCu8H?cluster=devnet
}
