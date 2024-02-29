import 'package:example/example/solana/quick_wallet_for_testing/quick_wallet.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  final owner1 = QuickWalletForTest(index: 400);
  SolAddress blockHash = await owner1.recentBlockhash();
  final layout = SystemAllocateLayout(space: BigInt.from(350));
  final program =
      SystemProgram.allocate(accountPubkey: owner1.address, layout: layout);
  final SolanaTransaction transaction = SolanaTransaction(
      instructions: [program],
      recentBlockhash: blockHash,
      payerKey: owner1.address,
      type: TransactionType.v0);
  transaction.sign([owner1.privateKey]);
  final ser = transaction.serializeString();
  await owner1.submitTr(ser);

  /// https://explorer.solana.com/tx/wswLLmsMXFLsb9UN7QngjJLWhE9NKRshdCfUpeeuvNwiAR6AvGJ8W749N1gCVhkTPrD58w9xADbwvoRcGDeDuyM?cluster=devnet
}
