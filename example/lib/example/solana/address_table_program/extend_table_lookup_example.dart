import 'package:example/example/solana/quick_wallet_for_testing/quick_wallet.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  final owner = QuickWalletForTest(index: 406);

  final account1 = QuickWalletForTest(index: 405);
  final account2 = QuickWalletForTest(index: 406);

  SolAddress blockHash = await owner.recentBlockhash();
  final tableAddress =
      AddressLookupTableProgramUtils.findAddressLookupTableProgram(
          authority: owner.address, recentSlot: BigInt.from(277777145));
  final layout = AddressExtendLookupTableLayout(addresses: [
    owner.address,
    account1.address,
    account2.address,
  ]);

  final program = AddressLookupTableProgram.extendLookupTable(
      authority: owner.address,
      lookupTable: tableAddress.address,
      payer: owner.address,
      layout: layout);

  final SolanaTransaction transaction = SolanaTransaction(
      instructions: [program],
      recentBlockhash: blockHash,
      payerKey: owner.address,
      type: TransactionType.v0);
  transaction.sign([owner.privateKey]);
  final ser = transaction.serializeString();
  await owner.submitTr(ser);

  /// https://explorer.solana.com/tx/5AmQMMvjs21riNLdma5LznwYdB8CX88jGNdaYWqFvNJig2xHYP4JxXLMa3BRrfkckHLE7jrPLoJMybKkgNozm43v?cluster=devnet
}
