import 'package:example/example/solana/quick_wallet_for_testing/quick_wallet.dart';
import 'package:on_chain/solana/solana.dart';

void main() async {
  final owner = QuickWalletForTest(index: 406);
  SolAddress blockHash = await owner.recentBlockhash();
  final tableAddress =
      AddressLookupTableProgramUtils.findAddressLookupTableProgram(
          authority: owner.address, recentSlot: BigInt.from(277777145));

  final program = AddressLookupTableProgram.deactivateLookupTable(
      authority: owner.address, lookupTable: tableAddress.address);

  final SolanaTransaction transaction = SolanaTransaction(
      instructions: [program],
      recentBlockhash: blockHash,
      payerKey: owner.address,
      type: TransactionType.v0);

  transaction.sign([owner.privateKey]);
  final ser = transaction.serializeString();
  await owner.submitTr(ser);

  /// https://explorer.solana.com/tx/3iRd92KfJZZVTKQta6az9E8iqm9Bmwe6r6Vp3x6aCk67huis1ttCmaEDrFaARBXcLbxjkdopC9GrmotXn5Pw4SsU?cluster=devnet
}
