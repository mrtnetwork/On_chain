import 'package:example/example/solana/quick_wallet_for_testing/quick_wallet.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  final owner = QuickWalletForTest(index: 255);

  final blockHash = await owner.recentBlockhash();
  const layout = SystemAssignLayout(programId: SystemProgramConst.programId);

  final create = SystemProgram.assign(layout: layout, account: owner.address);

  final SolanaTransaction transaction = SolanaTransaction(
      instructions: [create],
      recentBlockhash: blockHash,
      payerKey: owner.address,
      type: TransactionType.v0);

  final ownerSignature = owner.privateKey.sign(transaction.serializeMessage());

  transaction.addSignature(owner.address, ownerSignature);

  final ser = transaction.serializeString();
  await owner.submitTr(ser);

  /// https://explorer.solana.com/tx/iXm4f9ZUqBF3Mcp6bFvLSU55pqP7VCiRxNABD4DPVsjwVW5KfgbxbftMYzXTfJhoQyaXywBXxo6btjbhA1GtNqB?cluster=devnet
}
