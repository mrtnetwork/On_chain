import 'package:example/example/solana/quick_wallet_for_testing/quick_wallet.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  final owner = QuickWalletForTest(index: 406);
  SolAddress blockHash = await owner.recentBlockhash();
  final tableAddress =
      AddressLookupTableProgramUtils.findAddressLookupTableProgram(
          authority: owner.address, recentSlot: BigInt.from(277777145));
  final layout = AddressLookupCreateLookupTableLayout(
      bumpSeed: tableAddress.bump, recentSlot: BigInt.from(277777145));
  final program = AddressLookupTableProgram.createLookupTable(
      layout: layout,
      authority: owner.address,
      payer: owner.address,
      lookupTableAddress: tableAddress.address);

  final SolanaTransaction transaction = SolanaTransaction(
      instructions: [program],
      recentBlockhash: blockHash,
      payerKey: owner.address,
      type: TransactionType.v0);

  transaction.sign([owner.privateKey]);

  final ser = transaction.serializeString();
  await owner.submitTr(ser);

  /// https://explorer.solana.com/tx/ond92N5MeEPhqKBShuAftiY8wRBUzPaQh1VKwzJyv5SUDefkywKvMchbGzSL9Nojf9DGkiT4KgXMHviPj4QDyx8?cluster=devnet
}
